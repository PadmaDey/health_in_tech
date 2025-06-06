select  o.rec_id as opportunity_id, o.opportunity_name, tpa.tpa_name, a.agency_name,b.broker_name, eg.group_state, eg.group_sic_code, q.rec_id as quote_number, cast(q.quote_effective_date as date) as quote_effective_date, 
		case 
			when q.quote_status = 1 then 'Contingent' 
			else 'Final' 
		end as quote_status,
		case 
			when q.quote_selected = 1 then 'Ran and bought' 
			else 'Ran but not bought' 
		end as quote_selected,
		case 
			when q.is_active = '1'  then 'Active' 
			else 'Deleted' 
		end as active_status
into #temp_table
from 
	[prod_ediybs_replica].[prod].[opportunity] as o
inner join [prod_ediybs_replica].[prod].[quote] as q on o.rec_id = q.opportunity_id
inner join [prod_ediybs_replica].[prod].[program] as prg on q.[quote_program_id] = prg.[rec_id]
inner join [prod_ediybs_replica].[prod].[tpa] as tpa on prg.[tpa_id] = tpa.[rec_id]
inner join [prod_ediybs_replica].[prod].[broker] as b on q.broker_id = b.rec_id
inner join [prod_ediybs_replica].[prod].[agency] as a on b.broker_agency_id = a.rec_id
inner join [prod_ediybs_replica].[prod].[ediybs_group] as eg on o.group_id = eg.rec_id
;


with cte1 as(
select  temp.opportunity_id, temp.opportunity_name, temp.tpa_name, temp.agency_name, temp.broker_name, temp.opportunity_state, temp.opportunity_sic_code, temp.quote_number, temp.quote_effective_date, temp.quote_status
from #temp_table as temp
where temp.quote_status = 'Final'
)
select  cte1.opportunity_id, cte1.opportunity_name, cte1.tpa_name, cte1.agency_name, cte1.broker_name, cte1.opportunity_state, cte1.opportunity_sic_code, cte1.quote_number, cte1.quote_effective_date, 
cte1.quote_status, temp.quote_selected
from cte1
inner join #temp_table as temp on cte1.opportunity_id = temp.opportunity_id
;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



select  o.rec_id as opportunity_id, o.opportunity_name, tpa.tpa_name, a.agency_name,b.broker_name, o.opportunity_state, o.opportunity_sic_code, q.rec_id as quote_number, 
cast(q.quote_effective_date as date) as quote_effective_date, es.status_name as ediybs_status,
		case 
			when q.quote_status = 1 then 'Contingent' 
			else 'Final' 
		end as quote_status,
		case 
			when q.quote_selected = 1 then 'Ran and bought' 
			else 'Ran but not bought' 
		end as quote_selected,
		case 
			when q.is_active = '1'  then 'Active' 
			else 'Deleted' 
		end as active_status
into #temp_table
from 
	[prod_ediybs_replica].[prod].[opportunity] as o
inner join [prod_ediybs_replica].[prod].[quote] as q on o.rec_id = q.opportunity_id
inner join [prod_ediybs_replica].[prod].[program] as prg on q.[quote_program_id] = prg.[rec_id]
inner join [prod_ediybs_replica].[prod].[tpa] as tpa on prg.[tpa_id] = tpa.[rec_id]
inner join [prod_ediybs_replica].[prod].[broker] as b on q.broker_id = b.rec_id
inner join [prod_ediybs_replica].[prod].[agency] as a on b.broker_agency_id = a.rec_id
inner join [prod_ediybs_replica].[prod].[ediybs_group] as eg on o.group_id = eg.rec_id
inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.[opportunity_status_id] = es.[rec_id]
;


with cte1 as(
select  temp.opportunity_id, temp.opportunity_name, temp.tpa_name, temp.agency_name, temp.broker_name, temp.opportunity_state, temp.opportunity_sic_code, temp.quote_number, temp.quote_effective_date, temp.quote_status
from #temp_table as temp
where temp.quote_status = 'Final'
)
select distinct cte1.opportunity_id, cte1.opportunity_name, cte1.tpa_name, cte1.agency_name, cte1.broker_name, cte1.opportunity_state, cte1.opportunity_sic_code, cte1.quote_number, cte1.quote_effective_date, 
cte1.quote_status, temp.ediybs_status
from cte1
inner join #temp_table as temp on cte1.opportunity_id = temp.opportunity_id
--where temp.ediybs_status = 'Live'
order by cte1.opportunity_id
;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- total_opportunity_count_for_that_effective_dt
select temp.quote_effective_date, count(temp.opportunity_id) as total_opportunity_count_for_that_effective_dt
from #temp_table as temp
group by temp.quote_effective_date
order by temp.quote_effective_date;

-- total_opportunity_count_in_each_status
select temp.quote_effective_date, temp.quote_status, count(temp.opportunity_id) as total_opportunity_count_in_each_status
from #temp_table as temp
group by temp.quote_effective_date, temp.quote_status
order by temp.quote_effective_date;

-- total_sold
select temp.quote_effective_date, count(temp.opportunity_id) as total_sold
from #temp_table as temp
where temp.quote_selected = 'Ran and bought'
group by temp.quote_effective_date
order by temp.quote_effective_date;

-- total_left_in_final
select temp.quote_effective_date, count(temp.opportunity_id) as total_left_in_final
from #temp_table as temp
where temp.quote_status = 'Final' and temp.quote_selected = 'Ran and bought'
group by temp.quote_effective_date
order by temp.quote_effective_date;


-------------------------------------------------------------------------------------------------------------------------------------------------

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
			when e.[art_who] = 'SMR' and e.[art_type] = 'WA' then cast(qe.[expense_amount] as float)
			else 0
        end) as WA,
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
            when e.[art_who] = 'SMR' and e.[art_type] = 'NET2' then cast(qe.[expense_amount] as float)
            else 0
        end) as NET2,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'SMRF' then cast(qe.[expense_amount] as float)
            else 0
        end) as SMRF,
    sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'TECH' then cast(qe.[expense_amount] as float)
            else 0
        end) as TECH,
	sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'mktg' then cast(qe.[expense_amount] as float)
            else 0
        end) as MKTG,
	sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'MGA' then cast(qe.[expense_amount] as float)
            else 0
        end) as MGA,
	sum(case 
            when e.[art_who] = 'SMR' and e.[art_type] = 'LETT' then cast(qe.[expense_amount] as float)
            else 0
        end) as LGTT
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
			when right(eg.[policy_id], 2) = '01' then 'Y'
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
		cte3.WA,
		cte3.HCAR,
		cte3.HCRD,
		cte3.MKTF,
		cte3.NETF,
		cte3.OTHR,
		cte3.RPRF,
		cte3.SMR,
		cte3.NET2,
		cte3.SMRF,
		cte3.TECH,
		cte3.LGTT,
		cte3.MKTG,
		cte3.MGA,
		cte4.total, 
		p.[is_active] as person_is_active,
        eg.group_sic_code,
        eg.roster_id,
		pl.plan_name,
		eg.group_state
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
    inner join [prod_ediybs_replica].[prod].[plan] as pl on pl.[rec_id] = pp.[plan_id] and pl.[rec_id] = gqpd.[plan_id]
)

select distinct
    opportunity_name as 'Group Name', policy_id as 'Policy #', roster_id as 'Roster ID', group_state as 'State', renewal_y_or_n as 'Renewal Yes or No', null as 'Contract #', 
	tpa_name as 'TPA', network_name as 'Network Name', surplus_option as 'Surplus Option',quote_effective_date as 'Effective Date', network_type as 'Type', carrier_name as 'Carrier', 
	group_sic_code as 'SIC', plan_name as 'Plan Selection',
	ee_prem as 'EE Prem', ee_factor as 'EE Factor', ee_carr_fee as 'EE Carrier', es_prem as 'ES Prem', es_factor as 'ES Factor', es_carr_fee as 'ES Carrier', ec_prem as 'EC Prem', ec_factor as 'EC Factor', ec_carr_fee as 'EC Carrier', 
    ef_prem as 'EF Prem', ef_factor as 'EF Factor', ef_carr_fee as 'EF Carrier', 
    CAPM as 'Captive Mgmt', SMRF as 'SMR', HCAR as 'HI Card', MKTG as 'SMR Mktg', null as 'PMSMR', RPRF as 'Repricing', MGA as 'MGA', NETF as 'Health Smart', LGTT as 'SMR Legal', 
	NET2 as 'Network', ADMN as 'TPA', null as 'Fee1', null as 'Fee2', null as 'Fee3', null as 'Fee4', null as 'Fee5', null as 'Fee6', null as 'Fee7', null as 'Fee8', GA as 'GA', 
	MKTF as 'Broker',
	ee_census as 'EE Enrolled', es_census as 'ES Enrolled', ec_census as 'EC Enrolled', ef_census as 'EF Enrolled',
     
    ((ee_prem * ee_census) + (ec_prem * ec_census) + (es_prem * es_census) + (ef_prem * ef_census)) as 'Total Premium Billed Per Plan',
     WA as 'WA', 
	plan_name as 'Plan Name',
    ADMN as 'ADMN', BADM as 'BADM', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMRF as 'SMRF', 
    TECH as 'TECH', LGTT as 'LGTT', total as 'Total Non Recievable Admin Fees'
from cte1
WHERE 
    -- treaty_id in (31,32) and quote_selected = 1 and person_is_active = 1 and opportunity_name in (@opportunity_name) and surplus_option in (@surplus_option) and tpa_name in (@tpa_name) and ediybs_status in (@status_name) and renewal_y_or_n in (@renewal_y_or_n) and quote_effective_date  in (@quote_effective_date )
	treaty_id in (31,32) and quote_selected = 1 and person_is_active = 1  and opportunity_name LIKE '%ACT Concrete 2024%' and surplus_option = 0
order by plan_name;

/*
    group_name as 'eDIYBS Group Name', policy_id as 'Policy ID', renewal_y_or_n as 'Renewal Y or N', tpa_name as 'TPA Name', network_name as 'Network Name', surplus_option as 'Surplus Option', quote_effective_date as 'Quote Effective Date', 
    network_type as 'Network Type', carrier_name as 'Carrier Name', ee_prem as 'EE Prem', ee_factor as 'EE Factor', ee_carr_fee as 'EE Carr Fee', 
    quote_id, opportunity_id, rec_id as 'eDIYBS Group ID', plan_id as 'Plan ID', opportunity_name as 'Opportunity Name', ediybs_id as 'eDIYBS ID', ediybs_status as 'eDIYBS Status', treaty_name as 'Treaty Name', 
    ee_census as 'EE Census', es_census as 'ES Census', ec_census as 'EC Cencus', ef_census as 'EF Census', es_factor as 'ES Factor', ec_factor as 'EC Factor', ef_factor as 'EF Factor', es_prem as 'ES Prem', ec_prem as 'EC Prem'
    , ef_prem as 'EF Prem', es_carr_fee as 'ES Carr Fee', ec_carr_fee as 'EC Carr Fee', ef_carr_fee as 'EF Carr Fee', 
    ((ee_prem * ee_census) + (ec_prem * ec_census) + (es_prem * es_census) + (ef_prem * ef_census)) as 'Total Premium Billed Per Plan',
    ADMN as 'ADMN', BADM as 'BADM', CAPM as 'CAPM', GA as 'GA', HCAR as 'HCAR', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMR as 'SMR', SMRF as 'SMRF', 
    TECH as 'TECH', LGTT as 'LGTT', RPTT as 'RPTT', total as 'Total Non Recievable Admin Fees'
*/