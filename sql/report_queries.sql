# eDIYBS Opportunity Report: -

with cte4 as(
        select qe.[quote_id], 
		sum(cast(qe.[expense_amount] as float)) as total
        from [prod_ediybs_replica].[prod].[expenses] as e
        inner join [prod_ediybs_replica].[prod].[quote_expenses] as qe on e.[rec_id] = qe.[expense_id]
        where e.[art_who] <> 'SMR'
        group by qe.[quote_id]
),

cte3 as(
    select qe.[quote_id],
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'ADMN' then cast(qe.[expense_amount] as float)
            else 0
        end) as ADMN,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'BADM' then cast(qe.[expense_amount] as float)
            else 0
        end) as BADM,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'CAPM' then cast(qe.[expense_amount] as float)
            else 0
        end) as CAPM,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'GA' then cast(qe.[expense_amount] as float)
            else 0
        end) as GA,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'HCAR' then cast(qe.[expense_amount] as float)
            else 0
        end) as HCAR,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'HCRD' then cast(qe.[expense_amount] as float)
            else 0
        end) as HCRD,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'MKTF' then cast(qe.[expense_amount] as float)
            else 0
        end) as MKTF,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'NETF' then cast(qe.[expense_amount] as float)
            else 0
        end) as NETF,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'OTHR' then cast(qe.[expense_amount] as float)
            else 0
        end) as OTHR,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'RPRF' then cast(qe.[expense_amount] as float)
            else 0
        end) as RPRF,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'SMR' then cast(qe.[expense_amount] as float)
            else 0
        end) as SMR,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'SMRF' then cast(qe.[expense_amount] as float)
            else 0
        end) as SMRF,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'TECH' then cast(qe.[expense_amount] as float)
            else 0
        end) as TECH,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'LGTT' then cast(qe.[expense_amount] as float)
            else 0
        end) as LGTT,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'RPTT' then cast(qe.[expense_amount] as float)
            else 0
        end) as RPTT
    from [prod_ediybs_replica].[prod].[expenses] as e
    inner join [prod_ediybs_replica].[prod].[quote_expenses] as qe on e.[rec_id] = qe.[expense_id]
    group by qe.[quote_id]
),

cte2 as(
    select o.[rec_id], psp.[plan_id],
    sum(case 
        when p.[coverage_election] = 'EE'  then  1
        else 0
    end) as ee_census,
    sum(case 
        when p.[coverage_election] = 'ES' then  1
        else 0
    end) as es_census,
    sum(case 
        when p.[coverage_election] = 'EC' then  1
        else 0
    end) as ec_census,
    sum(case 
        when p.[coverage_election] = 'EF' then  1
        else 0
    end) as ef_census
    from [prod_ediybs_replica].[prod].[quote_census] as qc 
	inner join [prod_ediybs_replica].[prod].[person_selected_plan] as psp on qc.[quote_id] = psp.[quote_id] and qc.[person_id] = psp.[person_id]
	inner join [prod_ediybs_replica].prod.[person] as p on qc.[person_id] = p.[rec_id] and psp.[person_id] = p.[rec_id]
	inner join [prod_ediybs_replica].prod.[opportunity] as o on p.[opportunity_id] = o.[rec_id]
	where p.[person_relationship_code] = 1 and psp.[is_active] = 1
	group by o.rec_id, psp.plan_id
	--order by psp.plan_id
),

cte1 as(
    select 
		eg.[rec_id],
		eg.[group_name],
		qp.[is_active],
		gqpd.[quote_id],
		gqpd.[plan_id],
		gqpd.[surplus_option],
		o.[opportunity_name],
		o.[rec_id] as 'ediybs_id',
		c.[rec_id] as treaty_id,
		case 
			when o.[opportunity_name] like '%(R)%' then 'Y'
			else 'N'
		end as renewal_y_or_n,
		es.[status_name] as ediybs_status,
		tpa.[tpa_name],
		eg.[policy_id],
		q.[quote_effective_date],
		JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name') as treaty_name,
		c.[carrier_name],
		n.[network_name],
		n.[network_type],
		cte2.ee_census,
		cte2.es_census,
		cte2.ec_census,
		cte2.ef_census,
		q.[opportunity_id],
		q.[quote_selected],
		cast(gqpd.[au_factor_only_ee] as float) as ee_factor,
		cast(gqpd.[au_factor_only_ec] as float) as ec_factor,
		cast(gqpd.[au_factor_only_es] as float) as es_factor,
		cast(gqpd.[au_factor_only_ef] as float) as ef_factor,
		cast(gqpd.[premium_factor_only_ee] as float) as ee_prem,
		cast(gqpd.[premium_factor_only_ec] as float) as ec_prem,
		cast(gqpd.[premium_factor_only_es] as float) as es_prem,
		cast(gqpd.[premium_factor_only_ef] as float) as ef_prem,
		cast(gqpd.[carrier_markup_factor_only_ee] as float) as ee_carr_fee,
		cast(gqpd.[carrier_markup_factor_only_ec] as float)ec_carr_fee,
		cast(gqpd.[carrier_markup_factor_only_es] as float) as es_carr_fee,
		cast(gqpd.[carrier_markup_factor_only_ef] as float)ef_carr_fee,
		e.[art_who],
		e.[art_type],
		cast(qe.[expense_amount] as float) expense_amount,
		cte3.ADMN,
		cte3.BADM,
		cte3.CAPM,
		cte3.GA,
		cte3.HCAR,
		cte3.HCRD,
		cte3.MKTF,
		cte3.NETF,
		cte3.OTHR,
		cte3.RPRF,
		cte3.SMR,
		cte3.SMRF,
		cte3.TECH,
		cte3.LGTT,
		cte3.RPTT,
		cte4.total, 
		p.[is_active] as person_is_active
	from [prod_ediybs_replica].[prod].[quote] as q
	inner join [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd on q.[rec_id] = gqpd.[quote_id]
    inner join [prod_ediybs_replica].[prod].[carrier] as c on c.[rec_id] = q.[quote_carrier_id]
    inner join [prod_ediybs_replica].[prod].[network] as n on n.[rec_id] =  q.[quote_network_id]

    inner join [prod_ediybs_replica].[prod].[opportunity] as o on o.[rec_id] = q.[opportunity_id]
    inner join [prod_ediybs_replica].[prod].[ediybs_group] as eg on eg.[rec_id] = o.[group_id]
    inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.[opportunity_status_id] = es.[rec_id]

    inner join cte2 on o.[rec_id] = cte2.rec_id and gqpd.[plan_id] = cte2.plan_id
    inner join cte3 on q.[rec_id] = cte3.quote_id
    inner join cte4 on q.[rec_id] = cte4.quote_id

    inner join [prod_ediybs_replica].[prod].[program] as prg on  prg.[rec_id] = q.[quote_program_id]
    inner join [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.[rec_id] = prg.[tpa_id]

    inner join [prod_ediybs_replica].[prod].[quote_expenses] as qe on q.[rec_id] = qe.[quote_id]
    inner join [prod_ediybs_replica].[prod].[expenses] as e on e.[rec_id] = qe.[expense_id]

    inner join [prod_ediybs_replica].[prod].[quote_census] as qc on q.[rec_id] = qc.[quote_id]
    inner join [prod_ediybs_replica].[prod].[person] as p on p.[rec_id] = qc.[person_id]
    INNER join [prod_ediybs_replica].[prod].[quote_plans] as qp on qp.[quote_id] =gqpd.[quote_id] and qp.[plan_id] = gqpd.[plan_id]
    INNER join [prod_ediybs_replica].[prod].[program_plans] as pp on q.[quote_program_id] = pp.[program_id]
    inner join [prod_ediybs_replica].[prod].[plan] as pl on pl.[rec_id] = pp.[plan_id]
)

select distinct
    quote_id, opportunity_id, rec_id as 'eDIYBS Group ID', group_name as 'eDIYBS Group Name', plan_id as 'Plan ID', surplus_option as 'Surplus Option', opportunity_name as 'Opportunity Name', ediybs_id as 'eDIYBS ID', 
    renewal_y_or_n as 'Renewal Y or N', ediybs_status as 'eDIYBS Status', tpa_name as 'TPA Name', policy_id as 'Policy ID', quote_effective_date as 'Quote Effective Date', treaty_name as 'Treaty Name', 
    carrier_name as 'Carrier Name', network_name as 'Network Name', network_type as 'Network Type', ee_census as 'EE Census', es_census as 'ES Census', ec_census as 'EC Cencus', ef_census as 'EF Census', 
    ee_factor as 'EE Factor', es_factor as 'ES Factor', ec_factor as 'EC Factor', ef_factor as 'EF Factor', ee_prem as 'EE Prem', es_prem as 'ES Prem', ec_prem as 'EC Prem', ef_prem as 'EF Prem', 
    ee_carr_fee as 'EE Carr Fee', es_carr_fee as 'ES Carr Fee', ec_carr_fee as 'EC Carr Fee', ef_carr_fee as 'EF Carr Fee', 
    ((ee_prem * ee_census) + (ec_prem * ec_census) + (es_prem * es_census) + (ef_prem * ef_census)) as 'Total Premium Billed Per Plan',
    ADMN as 'ADMN', BADM as 'BADM', CAPM as 'CAPM', GA as 'GA', HCAR as 'HCAR', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMR as 'SMR', SMRF as 'SMRF', 
    TECH as 'TECH', LGTT as 'LGTT', RPTT as 'RPTT', total as 'Total Non Recievable Admin Fees'
from cte1
WHERE 
    treaty_id in (31,32) and quote_selected = 1 and person_is_active = 1 and opportunity_name in (@opportunity_name) and surplus_option in (@surplus_option) and tpa_name in (@tpa_name) and ediybs_status in (@status_name) and renewal_y_or_n in (@renewal_y_or_n) and quote_effective_date  in (@quote_effective_date )
	--treaty_id in (31,32) and quote_selected = 1 and person_is_active = 1  and opportunity_name LIKE '%71 Construction (R) 2023%' and surplus_option = 0
order by plan_id;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# eDIYBS Quote Report: -

select
    q.rec_id as 'Quote ID',
	q.opportunity_id as 'Opportunity ID',
    o.opportunity_name as 'Opportunity Name',
    eg.group_name as 'Group Name',
    eg.group_sic_code as 'SIC Code',
    p.program_name as 'Sales Program',
    q.uw_factor_used as 'Risk Score',
    q.quote_effective_date as 'Quote Effective Date',
    q.quote_name as 'Quote Name',
    eg.group_state as 'Quote State',
    count(
		case 
			when per.person_relationship_code = 1 then 1 
			--else 0
		end) as 'Total EE Lives',
    case 
		when q.quote_status = 1 then 'Contingent' 
		else 'Final' 
	end as 'Quote Status',
    q.creation_date as 'Create Date',
    n.network_name as 'Network',
    c.carrier_name as 'Carrier',
    case 
		when q.quote_selected = 1 then 'Ran and bought' 
		else 'Ran but not bought' 
	end as 'Selected Quote',
    case 
		when q.is_active = '1'  then 'Active' 
		else 'Deleted' 
	end as 'Is Active',
    tpa.tpa_name as 'TPA Name',
    ag.agency_name as 'Agency Name',
    b.broker_contact_name as 'Broker Name'

from [prod_ediybs_replica].[prod].[quote] as q
inner join [prod_ediybs_replica].[prod].[opportunity] as o on q.opportunity_id = o.rec_id
inner join [prod_ediybs_replica].[prod].[ediybs_group] as eg on o.group_id = eg.rec_id

inner join [prod_ediybs_replica].[prod].[program] as p on q.quote_program_id = p.rec_id
inner join [prod_ediybs_replica].[prod].[tpa] as tpa on p.tpa_id = tpa.rec_id

inner join [prod_ediybs_replica].[prod].[network] as n on q.quote_network_id = n.rec_id
inner join [prod_ediybs_replica].[prod].[carrier] as c on q.quote_carrier_id = c.rec_id

inner join [prod_ediybs_replica].[prod].[broker] as b on q.broker_id = b.rec_id
inner join [prod_ediybs_replica].[prod].[agency] as ag on b.broker_agency_id = ag.rec_id

inner join [prod_ediybs_replica].[prod].[quote_census] as qc on q.rec_id = qc.quote_id
inner join [prod_ediybs_replica].[prod].[person] as per on qc.person_id = per.rec_id

where ag.agency_name <> 'Stone Mountain Agency' 
	 and p.program_name in (@sales_program) and b.broker_contact_name in (@broker) and c.carrier_name in (@carrier) and n.network_name in (@network) and tpa.tpa_name in (@tpa) and q.quote_effective_date in (@quote_effective_date)
	 --and p.program_name = 'Array Health DIYBS' and b.broker_contact_name = 'Jay Hill' and c.carrier_name = 'Standard Life' and n.network_name = 'First Health Plus 5.50 HC MW3' and tpa.tpa_name = 'Array Health' and q.quote_effective_date = '2024-01-01'
group by
    q.rec_id,
    q.opportunity_id,
    eg.group_name,
    eg.group_sic_code,
    o.opportunity_name,
    p.program_name,
    q.uw_factor_used,
    q.quote_effective_date,
    q.quote_name,
    eg.group_state,
    q.creation_date,
    n.network_name,
    q.quote_status,
    c.carrier_name,
    q.quote_selected,
    q.is_active,
    tpa.tpa_name,
    ag.agency_name,
    b.broker_contact_name
order by
	q.rec_id;
    
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
# Visova Enrollment Report: -

-- MATRIX
WITH cte AS (
    SELECT 
        mem.mem_id1, 
        meme.meme_id2, 
        mem.mem_essan, 
        mem.mem_lname, 
        mem.mem_fname, 
        mem.mem_rel, 
        meme.meme_clir, 
        mem.mem_sex, 
        mem.mem_state, 
        mem.mem_zip, 
        meme.meme_lev2, 
        meme.meme_grpn, 
        mem.mem_dob, 
        clip.clip_eff,
        clip.clip_trm,
        meme.meme_eff, 
        meme.meme_trm,  
        meme.meme_plan,
        valid.val_desc,
		valid.val_type,
        case 
			when mem_rel = 1 then meme_depc
			else ''
		end as tier,
        ROW_NUMBER() OVER (PARTITION BY mem.mem_id1, meme.meme_id2 ORDER BY mem.mem_id1) AS row_no
    FROM 
        SSRS_visova.hit_vaas_test.mem AS mem
    INNER JOIN 
        SSRS_visova.hit_vaas_test.meme AS meme ON mem.mem_id1 = meme.meme_id1
    LEFT JOIN 
        SSRS_visova.hit_vaas_test.clip AS clip ON meme.meme_clir = clip.clip_id1 AND meme.meme_plan = clip.clip_plan
    INNER JOIN 
        SSRS_visova.hit_vaas_test.cli AS cli ON cli.cli_id1 = clip.clip_id1
    INNER JOIN
        SSRS_visova.hit_vaas_test.valid AS valid ON meme.meme_plan = valid.val_code
),
MonthStartDates AS (
    SELECT
        mem_id1, meme_id2, mem_essn, mem_lname, mem_fname, mem_rel, meme_clir, mem_sex, mem_state, mem_zip,
        meme_lev2, meme_grpn, mem_dob, clip_eff, clip_trm, meme_eff, meme_trm,
        meme_plan, val_desc, val_type, tier, row_no, 
        DATEADD(MONTH, DATEDIFF(MONTH, 0, meme_eff), 0) AS StartOfMonth -- Start date of meme_eff month
    FROM
        cte
    UNION ALL
    SELECT
        mem_id1, meme_id2, mem_essn, mem_lname, mem_fname, mem_rel, meme_clir, mem_sex, mem_state, mem_zip,
        meme_lev2, meme_grpn, mem_dob, clip_eff, clip_trm, meme_eff, meme_trm,
       meme_plan, val_desc,val_type, tier, row_no,
        DATEADD(MONTH, 1, StartOfMonth) AS StartOfMonth -- Next month's start date
    FROM
        MonthStartDates
    WHERE
        StartOfMonth < DATEADD(MONTH, -1, meme_trm)  -- Termination date
)
select 
    mem_lname as "LastName",
    mem_fname as "FirstName", 
    mem_rel as "Relation",
	tier as "Tier",
    mem_essn as "Family ID",
    mem_sex as "Gender", 
    mem_state as "State", 
    mem_zip as "Zip",  
    clip_eff as "Plan Effective Date",
    clip_trm as "Plan Termination Date",
    meme_eff as "Member Effective Date", 
    meme_trm as "Member Termination Date",
	cast(StartOfMonth as date) as "Month",
	DENSE_RANK() OVER (ORDER BY StartOfMonth) AS RowNumber,
    meme_grpn as "Test Group",
    meme_lev2 as "TPA",
    val_desc as "Plan Name",
    mem_dob as "DOB"
from 
	MonthStartDates
where cast(StartOfMonth as date) <= EOMONTH(GETDATE(), -1) and val_type = '529'and (tier is not null and tier != '') and meme_grpn in (@test_group) and clip_eff in (@plan_effective_date) and clip_trm in (@plan_termination_date)
group by 
	mem_lname, mem_fname, mem_rel, tier, mem_essn, mem_sex, mem_state, mem_zip, clip_eff, clip_trm, meme_eff, meme_trm, StartOfMonth, meme_grpn, meme_lev2, val_desc, mem_dob
order by mem_fname
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TABLE
with cte as (select 
	mem.mem_id1, 
    meme.meme_id2, 
    mem.mem_essn, 
    mem.mem_lname, 
    mem.mem_fname, 
    mem.mem_rel, 
    meme.meme_clir, 
    mem.mem_sex, 
    mem.mem_state, 
    mem.mem_zip,  
    meme.meme_lev2, 
    meme.meme_grpn, 
    mem.mem_dob, 
    clip.clip_eff,
    clip.clip_trm,
    meme.meme_eff, 
    meme.meme_trm,  
    meme.meme_plan, 
    meme.meme_depc,
    valid.val_desc,
    valid.val_type,
	ROW_NUMBER() over (partition by mem.mem_id1, meme.meme_id2 order by mem.mem_id1) as row_no
from 
	SSRS_visova.hit_vaas_test.mem as mem
inner join 
	SSRS_visova.hit_vaas_test.meme as meme on mem.mem_id1 = meme.meme_id1
left join 
	SSRS_visova.hit_vaas_test.clip as clip on meme.meme_clir = clip.clip_id1 and meme.meme_plan = clip.clip_plan
inner join 
	SSRS_visova.hit_vaas_test.cli as cli on cli.cli_id1 = clip.clip_id1
inner join
	SSRS_visova.hit_vaas_test.valid as valid on meme.meme_plan = valid.val_code
	)

select  
    mem_lname as "LastName",
    mem_fname as "FirstName", 
    mem_rel as "Relation",
    case 
		when mem_rel = 1 then meme_depc
        else ''
	end as "Tier",
    mem_essn as "Family ID",
    mem_sex as "Gender", 
    mem_state as "State", 
    mem_zip as "Zip",  
    clip_eff as "Plan Effective Date",
    clip_trm as "Plan Termination Date",
    meme_eff as "Member Effective Date", 
    meme_trm as "Member Termination Date",
    meme_grpn as "Test Group",
    meme_lev2 as "TPA",
    val_desc as "Plan Name",
    mem_dob as "DOB"
from 
	cte
where  val_type = '529' and meme_grpn in (@test_group) and clip_eff in (@plan_effective_date) and clip_trm in (@plan_termination_date)
group by 
	mem_lname, mem_fname, mem_rel, meme_depc, mem_essn, mem_sex, mem_state, mem_zip, clip_eff, clip_trm, meme_eff, meme_trm, meme_grpn, meme_lev2, val_desc, mem_dob
order by
	mem_fname
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Visova Member - Client Report: -

WITH RankedData AS (
    SELECT
        mem.mem_id1,
        ROW_NUMBER() OVER (PARTITION BY mem.mem_id1, meme.meme_id2 ORDER BY meme.meme_id1) AS row_num,
        meme.meme_id2,
        mem.mem_essn,
        mem.mem_lname,
        mem.mem_fname,
        mem.mem_rel,
        meme.meme_clir,
        mem.mem_sex,
        mem.mem_state,
        mem.mem_zip,
        meme.meme_lev1,
        meme.meme_lev2,
        meme.meme_lev3,
        meme.meme_grpn,
        mem.mem_dob,
        clip.clip_eff,
        meme.meme_eff,
        meme.meme_trm,
        meme.meme_net,
        meme.meme_prd,
        meme.meme_carr,
        meme.meme_plan,
        meme.meme_depc
    FROM [SSRS_visova_prod].[prod].[mem] as mem
    inner join [SSRS_visova_prod].[prod].[meme] as meme on mem.mem_id1 = meme.meme_id1
	inner join [SSRS_visova_prod].[prod].[clip] as clip on meme.meme_clir = clip.clip_id1 and meme.meme_plan = clip.clip_plan    
    --inner join [SSRS_visova_prod].[prod].[cli] as cli on cli.cli_id1 = clip.clip_id1
)
SELECT 
    rd.mem_id1 as 'Member ID',
    rd.meme_id2 as 'Member Plan Year',
    rd.mem_essn as 'Family ID',
    rd.mem_lname as 'Last Name',
    rd.mem_fname as 'First Name',
    rd.mem_rel as 'Relationship',
    rd.meme_clir as 'Client ID',
    rd.mem_sex as 'Gender',
    rd.mem_state as 'State',
    rd.mem_zip as 'Zip',
    rd.meme_lev1 as 'Selection Criteria 1',
    rd.meme_lev2 as 'Selection Criteria 2',
    rd.meme_lev3 as 'Selection Criteria 3',
    rd.meme_grpn as 'Group Name',
    rd.mem_dob as 'DOB',
    rd.clip_eff as 'Plan Effective Date',
    rd.meme_eff as 'Member Effective Date',
    rd.meme_trm as 'Member Term Date',
    rd.meme_net as 'Network',
    rd.meme_prd as 'PPO/RBP',
    rd.meme_carr as 'Carrier',
    rd.meme_plan as 'Plan ID',
    rd.meme_depc as 'Dependent Coverage'
FROM RankedData as rd
WHERE
--and rd.meme_carr = 'RSCN' and rd.meme_lev2 = 'MAK' and rd.meme_net = 'FH' and rd.meme_grpn = 'ALLCAT' and rd.clip_eff = '2022-12-01'
 rd.meme_carr in (@carrier) and rd.meme_lev2 in (@tpa) and rd.meme_net in (@network) and rd.meme_grpn in (@test_group) and rd.clip_eff in (@plan_eff_dt)
ORDER BY rd.mem_id1;