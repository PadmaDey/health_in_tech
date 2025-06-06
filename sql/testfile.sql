-- EDIYBS
SELECT
    q.rec_id AS Quote_ID,
    q.opportunity_id AS Opportunity_ID,
    o.opportunity_name AS Opportunity_name,
    eg.group_name AS Group_Name,
    eg.group_sic_code AS SIC_Code,
    p.program_name AS Sales_Program,
    q.uw_factor_used AS Risk_Score,
    q.quote_effective_date AS Quote_Effective_Date,
    q.quote_name AS Quote_Name,
    eg.group_state AS Quote_State,
    COUNT(CASE WHEN per.person_relationship_code = 1 THEN 1 END) AS Total_EE_Lives,
    CASE WHEN q.quote_status = 1 THEN 'Contingent' ELSE 'Final' END AS Quote_Status,
    q.creation_date AS Create_Date,
    n.network_name AS Network,
    car.carrier_name AS Carrier,
    CASE WHEN q.quote_selected = 1 THEN 'Ran and bought' ELSE 'Ran but not bought' END AS Selected_Quote,
    CASE WHEN q.is_active = 1 THEN 'Active' ELSE 'Deleted' END AS Is_Active,
    tpa.tpa_name AS TPA_Name,
    ag.agency_name AS Agency_Name,
    b.broker_contact_name AS Broker_Name
FROM
    [prod_ediybs_replica].[prod].[quote] AS q
JOIN
    [prod_ediybs_replica].[prod].[opportunity] AS o ON q.opportunity_id = o.rec_id
JOIN
    [prod_ediybs_replica].[prod].[ediybs_group] AS eg ON o.group_id = eg.rec_id
JOIN
    [prod_ediybs_replica].[prod].[program] AS p ON q.quote_program_id = p.rec_id
JOIN
    [prod_ediybs_replica].[prod].[network] AS n ON q.quote_network_id = n.rec_id
JOIN
    [prod_ediybs_replica].[prod].[carrier] AS car ON q.quote_carrier_id = car.rec_id
JOIN
    [prod_ediybs_replica].[prod].[tpa] AS tpa ON p.tpa_id = tpa.rec_id
JOIN
    [prod_ediybs_replica].[prod].[broker] AS b ON q.broker_id = b.rec_id
JOIN
    [prod_ediybs_replica].[prod].[agency] AS ag ON b.broker_agency_id = ag.rec_id
/*LEFT*/ JOIN
    [prod_ediybs_replica].[prod].[quote_census] AS qc ON q.rec_id = qc.quote_id
/*LEFT*/ JOIN
    [prod_ediybs_replica].[prod].[person] AS per ON qc.person_id = per.rec_id
GROUP BY
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
    car.carrier_name,
    q.quote_selected,
    q.is_active,
    tpa.tpa_name,
    ag.agency_name,
    b.broker_contact_name
ORDER BY 
q.quote_effective_date desc;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- ediybs
-- left anti join
with table_1 as (SELECT
    q.rec_id AS Quote_ID,
    q.opportunity_id AS Opportunity_ID,
    o.opportunity_name AS Opportunity_name,
    eg.group_name AS Group_Name,
    eg.group_sic_code AS SIC_Code,
    p.program_name AS Sales_Program,
    q.uw_factor_used AS Risk_Score,
    q.quote_effective_date AS Quote_Effective_Date,
    q.quote_name AS Quote_Name,
    eg.group_state AS Quote_State,
    COUNT(CASE WHEN per.person_relationship_code = 1 THEN 1 END) AS Total_EE_Lives,
    CASE WHEN q.quote_status = 1 THEN 'Contingent' ELSE 'Final' END AS Quote_Status,
    q.creation_date AS Create_Date,
    n.network_name AS Network,
    car.carrier_name AS Carrier,
    CASE WHEN q.quote_selected = 1 THEN 'Ran and bought' ELSE 'Ran but not bought' END AS Selected_Quote,
    CASE WHEN q.is_active = 1 THEN 'Active' ELSE 'Deleted' END AS Is_Active,
    tpa.tpa_name AS TPA_Name,
    ag.agency_name AS Agency_Name,
    b.broker_contact_name AS Broker_Name
FROM
    [prod_ediybs_replica].[prod].[quote] AS q
JOIN
    [prod_ediybs_replica].[prod].[opportunity] AS o ON q.opportunity_id = o.rec_id
JOIN
    [prod_ediybs_replica].[prod].[ediybs_group] AS eg ON o.group_id = eg.rec_id
JOIN
    [prod_ediybs_replica].[prod].[program] AS p ON q.quote_program_id = p.rec_id
JOIN
    [prod_ediybs_replica].[prod].[network] AS n ON q.quote_network_id = n.rec_id
JOIN
    [prod_ediybs_replica].[prod].[carrier] AS car ON q.quote_carrier_id = car.rec_id
JOIN
    [prod_ediybs_replica].[prod].[tpa] AS tpa ON p.tpa_id = tpa.rec_id
JOIN
    [prod_ediybs_replica].[prod].[broker] AS b ON q.broker_id = b.rec_id
JOIN
    [prod_ediybs_replica].[prod].[agency] AS ag ON b.broker_agency_id = ag.rec_id
left JOIN
    [prod_ediybs_replica].[prod].[quote_census] AS qc ON q.rec_id = qc.quote_id
left JOIN
    [prod_ediybs_replica].[prod].[person] AS per ON qc.person_id = per.rec_id
GROUP BY
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
    car.carrier_name,
    q.quote_selected,
    q.is_active,
    tpa.tpa_name,
    ag.agency_name,
    b.broker_contact_name
), 

table_2 as (SELECT
    q.rec_id AS Quote_ID,
    q.opportunity_id AS Opportunity_ID,
    o.opportunity_name AS Opportunity_name,
    eg.group_name AS Group_Name,
    eg.group_sic_code AS SIC_Code,
    p.program_name AS Sales_Program,
    q.uw_factor_used AS Risk_Score,
    q.quote_effective_date AS Quote_Effective_Date,
    q.quote_name AS Quote_Name,
    eg.group_state AS Quote_State,
    COUNT(CASE WHEN per.person_relationship_code = 1 THEN 1 END) AS Total_EE_Lives,
    CASE WHEN q.quote_status = 1 THEN 'Contingent' ELSE 'Final' END AS Quote_Status,
    q.creation_date AS Create_Date,
    n.network_name AS Network,
    car.carrier_name AS Carrier,
    CASE WHEN q.quote_selected = 1 THEN 'Ran and bought' ELSE 'Ran but not bought' END AS Selected_Quote,
    CASE WHEN q.is_active = 1 THEN 'Active' ELSE 'Deleted' END AS Is_Active,
    tpa.tpa_name AS TPA_Name,
    ag.agency_name AS Agency_Name,
    b.broker_contact_name AS Broker_Name
FROM
    [prod_ediybs_replica].[prod].[quote] AS q
JOIN
    [prod_ediybs_replica].[prod].[opportunity] AS o ON q.opportunity_id = o.rec_id
JOIN
    [prod_ediybs_replica].[prod].[ediybs_group] AS eg ON o.group_id = eg.rec_id
JOIN
    [prod_ediybs_replica].[prod].[program] AS p ON q.quote_program_id = p.rec_id
JOIN
    [prod_ediybs_replica].[prod].[network] AS n ON q.quote_network_id = n.rec_id
JOIN
    [prod_ediybs_replica].[prod].[carrier] AS car ON q.quote_carrier_id = car.rec_id
JOIN
    [prod_ediybs_replica].[prod].[tpa] AS tpa ON p.tpa_id = tpa.rec_id
JOIN
    [prod_ediybs_replica].[prod].[broker] AS b ON q.broker_id = b.rec_id
JOIN
    [prod_ediybs_replica].[prod].[agency] AS ag ON b.broker_agency_id = ag.rec_id
JOIN
    [prod_ediybs_replica].[prod].[quote_census] AS qc ON q.rec_id = qc.quote_id
JOIN
    [prod_ediybs_replica].[prod].[person] AS per ON qc.person_id = per.rec_id
GROUP BY
    q.rec_id, q.opportunity_id, eg.group_name, eg.group_sic_code, o.opportunity_name, p.program_name, q.uw_factor_used, q.quote_effective_date,
    q.quote_name, eg.group_state, q.creation_date, n.network_name, q.quote_status, car.carrier_name, q.quote_selected, q.is_active, tpa.tpa_name,
    ag.agency_name, b.broker_contact_name
)
SELECT * FROM Table_1 t1 LEFT JOIN Table_2 t2 ON t1.Quote_ID = t2.Quote_ID WHERE t2.Quote_ID IS NULL;

----------------------------------------------------------------------------------------------------------------------------------------------------

-- large group count
select meme.meme_grpn, count(mem.mem_id1)
from 
	SSRS_visova.hit_vaas_test.mem as mem
inner join 
	SSRS_visova.hit_vaas_test.meme as meme on mem.mem_id1 = meme.meme_id1
group by meme_grpn
order by count(mem.mem_id1) desc;

---------------------------------------------------------------------------------------------------------------------------------------
-- visova member & client report
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
    meme.meme_depc,
    valid.val_desc,
	ROW_NUMBER() over (partition by mem.mem_id1, meme.meme_id2 order by mem.mem_id1) as row_no
from 
	SSRS_visova.hit_vaas_test.mem as mem
inner join 
	SSRS_visova.hit_vaas_test.meme as meme on mem.mem_id1 = meme.meme_id1
left join 
	SSRS_visova.hit_vaas_test.clip as clip on meme.meme_clir = clip.clip_id1 
inner join 
	SSRS_visova.hit_vaas_test.cli as cli on cli.cli_id1 = clip.clip_id1
inner join
	SSRS_visova.hit_vaas_test.valid as valid on meme.meme_plan = valid.val_code
	)

select 
	mem_id1 as "Member ID", 
    meme_id2 as "Member Plan Year", 
    mem_essn as "Family ID", 
    mem_lname as "Last Name", 
    mem_fname as "First Name", 
    mem_rel as "Relationship", 
    meme_clir as "Client ID", 
    mem_sex as "Gender", 
    mem_state as "State", 
    mem_zip as "Zip", 
    meme_lev1 as "Selection Criteria 1", 
    meme_lev2 as "TPA", 
    meme_lev3 as "Selection Criteria 3", 
    meme_grpn as "Group Name", 
    mem_dob as "Selection_Criteria_3", 
    clip_eff as "Plan Effective Date", 
    meme_eff as "Member Effective Date", 
    meme_trm as "Member Term Date", 
    meme_net as "Network", 
    meme_prd as "PPO/RBP", 
    meme_carr as "Carrier", 
    val_desc as "Plan Name", 
    meme_depc as "Dependent Coverage"
from 
	cte
where row_no = 1
group by 
	mem_id1, meme_id2, mem_essn, meme_clir, mem_state, meme_net, meme_prd, meme_carr, val_desc, mem_rel, mem_sex, mem_zip, 
	meme_lev1, meme_lev2, meme_lev3, meme_grpn, mem_dob, clip_eff, meme_eff,meme_trm, meme_depc, mem_lname, mem_fname
order by 
	mem_id1
;    
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- visova enrollment report parameters

-- prm_test_group
/*select distinct meme_grpn
from [SSRS_visova].[hit_vaas_test].[meme]
ORDER BY meme_grpn;
*/

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
	),
	cte1 as(

select  
    meme_grpn
from 
	cte
where row_no = 1 and val_type = '529'
group by 
	mem_lname, mem_fname, mem_rel, meme_depc, mem_essn, mem_sex, mem_state, mem_zip, clip_eff, clip_trm, meme_eff, meme_trm, meme_grpn, meme_lev2, val_desc, mem_dob
)
select distinct meme_grpn
from cte1
group by meme_grpn
;

/*
-- prm_tpa
select distinct meme_lev2
from [SSRS_visova].[hit_vaas_test].[meme]
where meme_grpn = @test_group;
*/

-- prm_plan_effective_date
select 
         distinct clip.clip_eff
from 
         [SSRS_visova].[hit_vaas_test].[meme] as meme
left join 
         SSRS_visova.hit_vaas_test.clip as clip on meme.meme_clir = clip.clip_id1 and meme.meme_plan = clip.clip_plan
where meme_grpn = @test_group;

-- prm_plan_termination_date
select 
         distinct clip.clip_trm
from 
         [SSRS_visova].[hit_vaas_test].[meme] as meme
left join 
         SSRS_visova.hit_vaas_test.clip as clip on meme.meme_clir = clip.clip_id1 and meme.meme_plan = clip.clip_plan
where meme.meme_grpn = @test_group 
    and clip.clip_eff in (@plan_effective_date);
--------------------------------------------------------------------------------------------------------------------------------------

-- visova enrollment report - table

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
where  val_type = '529' 
group by 
	mem_lname, mem_fname, mem_rel, meme_depc, mem_essn, mem_sex, mem_state, mem_zip, clip_eff, clip_trm, meme_eff, meme_trm, meme_grpn, meme_lev2, val_desc, mem_dob
order by
	mem_fname
;

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- visova enrollment- matrix report

WITH cte AS (
    SELECT 
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
where cast(StartOfMonth as date) <= EOMONTH(GETDATE(), -1) and val_type = '529'and (tier is not null and tier != '') 
group by 
	mem_lname, mem_fname, mem_rel, tier, mem_essn, mem_sex, mem_state, mem_zip, clip_eff, clip_trm, meme_eff, meme_trm, StartOfMonth, meme_grpn, meme_lev2, val_desc, mem_dob
order by mem_fname
;

----------------------------------------------------------------------------------------------------------------------------------------------------                        
-- person_details from ediybs
SELECT pers.[rec_id]
      ,[person_first_name] AS 'FIRST NAME'
      ,[person_last_name]AS 'LAST NAME'
      ,[person_addr1]AS 'ADDRESS'
      ,[person_city]AS 'CITY'
      ,[person_state]AS 'STATE'
      ,[person_zip]AS 'ZIP'
      ,[person_gender]AS 'GENDER'
      ,pers.[is_active]AS 'IS ACTIVE'
      ,medcon.[medical_condition_onset_date]AS 'Medical Condition Onset Date'
      ,medcon.[medical_condition_end_date]AS 'Medical Condition End Date'
      ,medcon.[medical_condition_notes]AS 'Medical Condition Notes'
      ,healthnote.[health_app_note]AS 'Health App Notes'
      ,[ageSexFactor]AS 'Age-Sex-Factor'
      ,[areaFactor]AS 'Area Factor'
      ,[verakai_risk_score]AS 'Verakai Risk Score'
      ,riskscprov.[risk_score_provider_description]AS 'Risk Score Provider'
      ,risksc.[risk_score]AS 'Risk Score'
      ,[person_relationship_code]AS 'Relationship'
      ,[person_family_id]AS 'Family Id'
      ,[person_age]AS 'Age'
      ,[person_nha]AS '_nha'
  FROM [prod_ediybs_replica].[prod].[person] AS pers 

LEFT JOIN [prod_ediybs_replica].[prod].[person_medical_condition] AS medcon ON  pers.rec_id = medcon.person_id

LEFT JOIN [prod_ediybs_replica].[prod].[person_risk_score] AS risksc ON  pers.rec_id = risksc.person_id

LEFT JOIN [prod_ediybs_replica].[prod].[person_health_app_notes] AS healthnote ON  pers.rec_id = healthnote.person_id

LEFT JOIN [prod_ediybs_replica].[prod].[risk_score_provider] AS riskscprov ON  risksc.risk_score_provider_id = riskscprov.rec_id;

----------------------------------------------------------------------------------------------------------------

-- eDIYBS Opportunity Reports
with cte1 as(
SELECT distinct
	eg.rec_id,
    eg.[group_name],
    pl.[rec_id] as plan_id,
	gqpd.[surplus_option],
    o.[opportunity_name],
    o_notes.[opportunity_id],
    c.rec_id as treaty_id,
	case 
		when o.[opportunity_name] like '%(R)%' then 'Y'
		else 'N'
	end as renewal_y_or_n,
	es.status_name as ediybs_status,
	tpa.[tpa_name],
	eg.[policy_id],
	q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name') as treaty_name,
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
	case 
			when p.[coverage_election] = 'EE'  then  count(p.[coverage_election])
			else ''
		end as ee_cencus,
        case 
			when p.[coverage_election] = 'ES' then  count(p.[coverage_election])
			else ''
		end as es_cencus,
        case 
			when p.[coverage_election] = 'EC' then  count(p.[coverage_election])
			else ''
		end as ec_cencus,
        case 
			when p.[coverage_election] = 'EF' then  count(p.[coverage_election])
			else ''
		end as ef_cencus,
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
    case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'ADMN' then  cast(qe.[expense_amount] as float)
        else ''
	  end as ADMN,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'BADM' then  cast(qe.[expense_amount] as float)
        else ''
	  end as BADM,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'CAPM' then  cast(qe.[expense_amount] as float)
        else ''
	  end as CAPM,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'GA' then  cast(qe.[expense_amount] as float)
        else ''
	  end as GA,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'HCAR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as HCAR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'HCRD' then  cast(qe.[expense_amount] as float)
        else ''
	  end as HCRD,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'MKTF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as MKTF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'NETF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as NETF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'OTHR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as OTHR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'RPRF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as RPRF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'SMR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as SMR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'SMRF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as SMRF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'TECH' then  cast(qe.[expense_amount] as float)
        else ''
	  end as TECH,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'LGTT' then  cast(qe.[expense_amount] as float)
        else ''
	  end as LGTT,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'RPTT' then  cast(qe.[expense_amount] as float)
        else ''
	  end as RPTT,
	  case 
		when e.art_who != 'SMR' and e.art_type like '%ADMN%' and e.art_type like '%BADM%' and e.art_type like '%CAPM%' and e.art_type like '%GA%' and e.art_type like '%HCRD%' and e.art_type like '%MKTF%' and e.art_type like '%NETF%' and e.art_type like '%OTHR%' and e.art_type like '%RPRF%' and e.art_type like '%SMR%' and e.art_type like '%SMRF%' and e.art_type like '%TECH%' and e.art_type like '%LGTT%' and e.art_type like '%RPTT%' then  sum(cast(qe.[expense_amount] as float))
        else ''
	  end as total
FROM 
    [prod_ediybs_replica].[prod].[quote] as q
    left JOIN [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd on q.rec_id = gqpd.quote_id
    left JOIN [prod_ediybs_replica].[prod].[carrier] as c on c.rec_id = q.quote_carrier_id
    left JOIN [prod_ediybs_replica].[prod].[network] as n on n.rec_id =  q.quote_network_id
	inner JOIN [prod_ediybs_replica].[prod].[quote_surplus_option] as qso on qso.quote_id = gqpd.quote_id

    left JOIN [prod_ediybs_replica].[prod].[opportunity] as o on o.rec_id = q.opportunity_id
    left JOIN [prod_ediybs_replica].[prod].[opportunity_notes] as o_notes on o.rec_id = o_notes.opportunity_id
    left JOIN [prod_ediybs_replica].[prod].[ediybs_group] as eg on eg.rec_id = o.group_id
	inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id

    left JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
    left JOIN [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id

    left JOIN [prod_ediybs_replica].[prod].[quote_expenses] as qe on q.rec_id = qe.quote_id
    left JOIN [prod_ediybs_replica].[prod].[expenses] as e on e.rec_id = qe.expense_id

    left JOIN [prod_ediybs_replica].[prod].[quote_census] as qc on q.rec_id = qc.quote_id
    left JOIN [prod_ediybs_replica].[prod].[person] as p on p.rec_id = qc.person_id

    INNER JOIN [prod_ediybs_replica].[prod].[program_plans] as pp on q.quote_program_id = pp.program_id
    left JOIN [prod_ediybs_replica].[prod].[plan] as pl on pl.rec_id = pp.plan_id

	group by eg.rec_id,
    eg.[group_name],
    pl.[rec_id],
    gqpd.[surplus_option],
    o.[opportunity_name],
    o_notes.[opportunity_id],
    c.rec_id,
    CASE 
        WHEN o.[opportunity_name] LIKE '%(R)%' THEN 'Y'
        ELSE 'N'
    END,
    es.status_name,
    tpa.[tpa_name],
    eg.[policy_id],
    q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name'),
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
    p.[coverage_election],
    gqpd.[au_factor_only_ee],
    gqpd.[au_factor_only_ec],
    gqpd.[au_factor_only_es],
    gqpd.[au_factor_only_ef],
    gqpd.[premium_factor_only_ee],
    gqpd.[premium_factor_only_ec],
    gqpd.[premium_factor_only_es],
    gqpd.[premium_factor_only_ef],
    gqpd.[carrier_markup_factor_only_ee],
    gqpd.[carrier_markup_factor_only_ec],
    gqpd.[carrier_markup_factor_only_es],
    gqpd.[carrier_markup_factor_only_ef],
    e.[art_who],
    e.[art_type],
    qe.[expense_amount]
)
select distinct
	rec_id as 'Ediybs Group ID', group_name as 'Group Name', plan_id as 'Plan ID', surplus_option as 'Surplus Option', opportunity_name as 'Opportunity Name', opportunity_id as 'Ediybs ID', 
	renewal_y_or_n as 'Renewal Y or N', ediybs_status as 'Ediybs Status', tpa_name as 'TPA Name', policy_id as 'Policy ID', quote_effective_date as 'Quote Effective Date', treaty_name as 'Treaty Name', 
	carrier_name as 'Carrier Name', network_name as 'Network Name', network_type as 'Network Type', ee_cencus as 'EE Cencus', es_cencus as 'ES Cencus', ec_cencus as 'EC Cencus', ef_cencus as 'EF Cencus', 
	ee_factor as 'EE Factor', es_factor as 'ES Factor', ec_factor as 'EC Factor', ef_factor as 'EF Factor', ee_prem as 'EE Prem', es_prem as 'ES Prem', ec_prem as 'EC Prem', ef_prem as 'EF Prem', 
	ee_carr_fee as 'EE Carr Fee', es_carr_fee as 'ES Carr Fee', ec_carr_fee as 'EC Carr Fee', ef_carr_fee as 'EF Carr Fee', 
    ((ee_prem * ee_cencus) + (ec_prem * ec_cencus) + (es_prem * es_cencus) + (ef_prem * ef_cencus)) as 'Total Premium Billed Per Plan',
    ADMN as 'ADMN', BADM as 'BADM', CAPM as 'CAPM', GA as 'GA', HCAR as 'HCAR', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMR as 'SMR', SMRF as 'SMRF', 
	TECH as 'TECH', LGTT as 'LGTT', RPTT as 'RPTT', total as 'Total Non Recievable Admin Fees'
from cte1
WHERE 
    treaty_id in (31,32)  and rec_id in (2919,6084,10009040, 10010297,3202)
order by group_name;

-----------------------------------------------------------------------------------------------------------------------------
-- eDIYBS Opportunity Reports parameters

-- opportunity_name
select distinct o.opportunity_name
from [prod_ediybs_replica].[prod].[opportunity] as o

--------------------------------------------------

-- tpa
select distinct tpa.[tpa_name] 
from [prod_ediybs_replica].[prod].[tpa] as tpa 
inner JOIN [prod_ediybs_replica].[prod].[program] as prg on tpa.rec_id = prg.tpa_id
inner JOIN [prod_ediybs_replica].[prod].[quote] as q on  prg.rec_id = q.quote_program_id
inner join[prod_ediybs_replica].[prod].[opportunity] as o on q.opportunity_id = o.rec_id 
where o.opportunity_name = @opportunity_name;

------------------------------------------------

-- ediybs_status
select distinct es.[status_name] 
from [prod_ediybs_replica].[prod].[ediybs_status] as es
inner join [prod_ediybs_replica].[prod].[opportunity] as o on o.opportunity_status_id = es.rec_id
inner join[prod_ediybs_replica].[prod].[quote] as q on q.opportunity_id = o.rec_id 
inner JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
inner join [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id
where o.opportunity_name = @opportunity_name and tpa.tpa_name = @tpa;

-----------------------------------------

-- renewal
select distinct 
				case 
					when o.[opportunity_name] like '%(R)%' then 'Y'
					else 'N'
				end as renewal_y_or_n
from [prod_ediybs_replica].[prod].[opportunity] as o
inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id
inner join[prod_ediybs_replica].[prod].[quote] as q on q.opportunity_id = o.rec_id 
inner JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
inner join [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id
where o.opportunity_name = @opportunity_name and tpa.tpa_name = @tpa and es.status_name = @ediybs_status;

------------------------------------------

-- surplus_option
select distinct gqpd.[surplus_option]
from [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd
inner JOIN [prod_ediybs_replica].[prod].[quote] as q on q.rec_id = gqpd.quote_id
inner JOIN [prod_ediybs_replica].[prod].[opportunity] as o on o.rec_id = q.opportunity_id
inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id
inner JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
inner join [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id
where o.opportunity_name = @opportunity_name and tpa.tpa_name = @tpa and es.status_name = @ediybs_status and 
case 
	when o.[opportunity_name] like '%(R)%' then 'Y'
	else 'N'
end = (@renewal_option);

---------------------------------------------

-- quote_effective_date
select distinct cast(q.[quote_effective_date] as date) quote_eff_date
from [prod_ediybs_replica].[prod].[quote] as q
inner JOIN [prod_ediybs_replica].[prod].[opportunity] as o on o.rec_id = q.opportunity_id
inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id
inner JOIN [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd on q.rec_id = gqpd.quote_id
inner JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
inner join [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id
where o.opportunity_name = @opportunity_name and tpa.tpa_name = @tpa and es.status_name = @ediybs_status and 
case 
	when o.[opportunity_name] like '%(R)%' then 'Y'
	else 'N'
end = @renewal_option and gqpd.surplus_option = @surplus_option
order by cast(q.[quote_effective_date] as date); 

-----------------------------------------------------------
-- prm_plan_effective_date
select 
         distinct clip.clip_eff
from 
         [SSRS_visova].[hit_vaas_test].[meme] as meme
left join 
         SSRS_visova.hit_vaas_test.clip as clip on meme.meme_clir = clip.clip_id1 and meme.meme_plan = clip.clip_plan
where meme_grpn = @test_group;

-- prm_plan_termination_date
select 
         distinct clip.clip_trm
from 
         [SSRS_visova].[hit_vaas_test].[meme] as meme
left join 
         SSRS_visova.hit_vaas_test.clip as clip on meme.meme_clir = clip.clip_id1 and meme.meme_plan = clip.clip_plan
where meme.meme_grpn = @test_group 
    and clip.clip_eff in (@plan_effective_date);

-------------------------------------------------------------------------------------------------------------------------------------

-- new_ediybs_opportunity_report by using stored procedure


create proc GetFilteredData
	@quote_eff_date DATE,
    @ediybs_status varchar,
	@renewal_option varchar,
	@surplus_option varchar
AS
BEGIN
with cte1 as(
SELECT distinct
	eg.rec_id,
    eg.[group_name],
    pl.[rec_id] as plan_id,
	gqpd.[surplus_option],
    o.[opportunity_name],
    o_notes.[opportunity_id],
    c.rec_id as treaty_id,
	case 
		when o.[opportunity_name] like '%(R)%' then 'Y'
		else 'N'
	end as renewal_y_or_n,
	es.status_name as ediybs_status,
	tpa.[tpa_name],
	eg.[policy_id],
	q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name') as treaty_name,
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
	case 
			when p.[coverage_election] = 'EE'  then  count(p.[coverage_election])
			else ''
		end as ee_cencus,
        case 
			when p.[coverage_election] = 'ES' then  count(p.[coverage_election])
			else ''
		end as es_cencus,
        case 
			when p.[coverage_election] = 'EC' then  count(p.[coverage_election])
			else ''
		end as ec_cencus,
        case 
			when p.[coverage_election] = 'EF' then  count(p.[coverage_election])
			else ''
		end as ef_cencus,
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
    case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'ADMN' then  cast(qe.[expense_amount] as float)
        else ''
	  end as ADMN,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'BADM' then  cast(qe.[expense_amount] as float)
        else ''
	  end as BADM,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'CAPM' then  cast(qe.[expense_amount] as float)
        else ''
	  end as CAPM,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'GA' then  cast(qe.[expense_amount] as float)
        else ''
	  end as GA,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'HCAR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as HCAR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'HCRD' then  cast(qe.[expense_amount] as float)
        else ''
	  end as HCRD,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'MKTF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as MKTF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'NETF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as NETF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'OTHR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as OTHR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'RPRF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as RPRF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'SMR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as SMR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'SMRF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as SMRF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'TECH' then  cast(qe.[expense_amount] as float)
        else ''
	  end as TECH,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'LGTT' then  cast(qe.[expense_amount] as float)
        else ''
	  end as LGTT,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'RPTT' then  cast(qe.[expense_amount] as float)
        else ''
	  end as RPTT,
	  case 
		when e.art_who != 'SMR' and e.art_type like '%ADMN%' and e.art_type like '%BADM%' and e.art_type like '%CAPM%' and e.art_type like '%GA%' and e.art_type like '%HCRD%' and e.art_type like '%MKTF%' and e.art_type like '%NETF%' and e.art_type like '%OTHR%' and e.art_type like '%RPRF%' and e.art_type like '%SMR%' and e.art_type like '%SMRF%' and e.art_type like '%TECH%' and e.art_type like '%LGTT%' and e.art_type like '%RPTT%' then  sum(cast(qe.[expense_amount] as float))
        else ''
	  end as total
FROM 
    [prod_ediybs_replica].[prod].[quote] as q
    left JOIN [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd on q.rec_id = gqpd.quote_id
    left JOIN [prod_ediybs_replica].[prod].[carrier] as c on c.rec_id = q.quote_carrier_id
    left JOIN [prod_ediybs_replica].[prod].[network] as n on n.rec_id =  q.quote_network_id
	inner JOIN [prod_ediybs_replica].[prod].[quote_surplus_option] as qso on qso.quote_id = gqpd.quote_id

    left JOIN [prod_ediybs_replica].[prod].[opportunity] as o on o.rec_id = q.opportunity_id
    left JOIN [prod_ediybs_replica].[prod].[opportunity_notes] as o_notes on o.rec_id = o_notes.opportunity_id
    left JOIN [prod_ediybs_replica].[prod].[ediybs_group] as eg on eg.rec_id = o.group_id
	inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id

    left JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
    left JOIN [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id

    left JOIN [prod_ediybs_replica].[prod].[quote_expenses] as qe on q.rec_id = qe.quote_id
    left JOIN [prod_ediybs_replica].[prod].[expenses] as e on e.rec_id = qe.expense_id

    left JOIN [prod_ediybs_replica].[prod].[quote_census] as qc on q.rec_id = qc.quote_id
    left JOIN [prod_ediybs_replica].[prod].[person] as p on p.rec_id = qc.person_id

    INNER JOIN [prod_ediybs_replica].[prod].[program_plans] as pp on q.quote_program_id = pp.program_id
    left JOIN [prod_ediybs_replica].[prod].[plan] as pl on pl.rec_id = pp.plan_id

	group by eg.rec_id,
    eg.[group_name],
    pl.[rec_id],
    gqpd.[surplus_option],
    o.[opportunity_name],
    o_notes.[opportunity_id],
    c.rec_id,
    CASE 
        WHEN o.[opportunity_name] LIKE '%(R)%' THEN 'Y'
        ELSE 'N'
    END,
    es.status_name,
    tpa.[tpa_name],
    eg.[policy_id],
    q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name'),
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
    p.[coverage_election],
    gqpd.[au_factor_only_ee],
    gqpd.[au_factor_only_ec],
    gqpd.[au_factor_only_es],
    gqpd.[au_factor_only_ef],
    gqpd.[premium_factor_only_ee],
    gqpd.[premium_factor_only_ec],
    gqpd.[premium_factor_only_es],
    gqpd.[premium_factor_only_ef],
    gqpd.[carrier_markup_factor_only_ee],
    gqpd.[carrier_markup_factor_only_ec],
    gqpd.[carrier_markup_factor_only_es],
    gqpd.[carrier_markup_factor_only_ef],
    e.[art_who],
    e.[art_type],
    qe.[expense_amount]
)
select distinct
	rec_id as 'Ediybs Group ID', group_name as 'Group Name', plan_id as 'Plan ID', surplus_option as 'Surplus Option', opportunity_name as 'Opportunity Name', opportunity_id as 'Ediybs ID', 
	renewal_y_or_n as 'Renewal Y or N', ediybs_status as 'Ediybs Status', tpa_name as 'TPA Name', policy_id as 'Policy ID', quote_effective_date as 'Quote Effective Date', treaty_name as 'Treaty Name', 
	carrier_name as 'Carrier Name', network_name as 'Network Name', network_type as 'Network Type', ee_cencus as 'EE Cencus', es_cencus as 'ES Cencus', ec_cencus as 'EC Cencus', ef_cencus as 'EF Cencus', 
	ee_factor as 'EE Factor', es_factor as 'ES Factor', ec_factor as 'EC Factor', ef_factor as 'EF Factor', ee_prem as 'EE Prem', es_prem as 'ES Prem', ec_prem as 'EC Prem', ef_prem as 'EF Prem', 
	ee_carr_fee as 'EE Carr Fee', es_carr_fee as 'ES Carr Fee', ec_carr_fee as 'EC Carr Fee', ef_carr_fee as 'EF Carr Fee', 
    ((ee_prem * ee_cencus) + (ec_prem * ec_cencus) + (es_prem * es_cencus) + (ef_prem * ef_cencus)) as 'Total Premium Billed Per Plan',
    ADMN as 'ADMN', BADM as 'BADM', CAPM as 'CAPM', GA as 'GA', HCAR as 'HCAR', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMR as 'SMR', SMRF as 'SMRF', 
	TECH as 'TECH', LGTT as 'LGTT', RPTT as 'RPTT', total as 'Total Non Recievable Admin Fees'
from cte1
WHERE 
    treaty_id in (31,32)  and 
	(quote_effective_date like @quote_eff_date or @quote_eff_date is null) and 
	(ediybs_status like @ediybs_status or @ediybs_status is null) and 
	(renewal_y_or_n like @renewal_option or renewal_y_or_n is null) and 
	(surplus_option like @surplus_option or @surplus_option is null)
order by group_name
END;
 

EXEC GetFilteredData '2024-04-01 00:00:00', 'Live', 'Y', '0';

USE prod_ediybs_replica
GO
call dbo.GetFilteredData @quote_eff_date = N'2023-08-01 00:00:00', 
					@ediybs_status = N'Live', 
					@renewal_option = N'Y', 
					@surplus_option = N'0';

--------------------------------------------------------------------------------------------------------------------------------------------------------
*****************************************************************************************************************************************************
--------------------------------------------------------------------------------------------------------------------------------------------------------

with cte1 as(
SELECT distinct
	eg.rec_id,
    eg.[group_name],
    pl.[rec_id] as plan_id,
	gqpd.[surplus_option],
    o.[opportunity_name],
    o.[rec_id] as 'ediybs_id',
    c.rec_id as treaty_id,
	case 
		when o.[opportunity_name] like '%(R)%' then 'Y'
		else 'N'
	end as renewal_y_or_n,
	es.status_name as ediybs_status,
	tpa.[tpa_name],
	eg.[policy_id],
	q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name') as treaty_name,
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
	case 
			when p.[coverage_election] = 'EE'  then  count(p.[coverage_election])
			else ''
		end as ee_cencus,
        case 
			when p.[coverage_election] = 'ES' then  count(p.[coverage_election])
			else ''
		end as es_cencus,
        case 
			when p.[coverage_election] = 'EC' then  count(p.[coverage_election])
			else ''
		end as ec_cencus,
        case 
			when p.[coverage_election] = 'EF' then  count(p.[coverage_election])
			else ''
		end as ef_cencus,
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
    case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'ADMN' then  cast(qe.[expense_amount] as float)
        else ''
	  end as ADMN,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'BADM' then  cast(qe.[expense_amount] as float)
        else ''
	  end as BADM,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'CAPM' then  cast(qe.[expense_amount] as float)
        else ''
	  end as CAPM,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'GA' then  cast(qe.[expense_amount] as float)
        else ''
	  end as GA,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'HCAR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as HCAR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'HCRD' then  cast(qe.[expense_amount] as float)
        else ''
	  end as HCRD,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'MKTF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as MKTF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'NETF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as NETF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'OTHR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as OTHR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'RPRF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as RPRF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'SMR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as SMR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'SMRF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as SMRF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'TECH' then  cast(qe.[expense_amount] as float)
        else ''
	  end as TECH,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'LGTT' then  cast(qe.[expense_amount] as float)
        else ''
	  end as LGTT,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'RPTT' then  cast(qe.[expense_amount] as float)
        else ''
	  end as RPTT,
	  case 
		when e.art_who != 'SMR' and e.art_type like '%ADMN%' and e.art_type like '%BADM%' and e.art_type like '%CAPM%' and e.art_type like '%GA%' and e.art_type like '%HCRD%' and e.art_type like '%MKTF%' and e.art_type like '%NETF%' and e.art_type like '%OTHR%' and e.art_type like '%RPRF%' and e.art_type like '%SMR%' and e.art_type like '%SMRF%' and e.art_type like '%TECH%' and e.art_type like '%LGTT%' and e.art_type like '%RPTT%' then  sum(cast(qe.[expense_amount] as float))
        else ''
	  end as total
FROM 
    [prod_ediybs_replica].[prod].[quote] as q
    left JOIN [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd on q.rec_id = gqpd.quote_id
    left JOIN [prod_ediybs_replica].[prod].[carrier] as c on c.rec_id = q.quote_carrier_id
    left JOIN [prod_ediybs_replica].[prod].[network] as n on n.rec_id =  q.quote_network_id
	inner JOIN [prod_ediybs_replica].[prod].[quote_surplus_option] as qso on qso.quote_id = gqpd.quote_id

    left JOIN [prod_ediybs_replica].[prod].[opportunity] as o on o.rec_id = q.opportunity_id
    /*left JOIN [prod_ediybs_replica].[prod].[opportunity_notes] as o_notes on o.rec_id = o_notes.opportunity_id*/
    left JOIN [prod_ediybs_replica].[prod].[ediybs_group] as eg on eg.rec_id = o.group_id
	inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id

    left JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
    left JOIN [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id

    left JOIN [prod_ediybs_replica].[prod].[quote_expenses] as qe on q.rec_id = qe.quote_id
    left JOIN [prod_ediybs_replica].[prod].[expenses] as e on e.rec_id = qe.expense_id

    left JOIN [prod_ediybs_replica].[prod].[quote_census] as qc on q.rec_id = qc.quote_id
    left JOIN [prod_ediybs_replica].[prod].[person] as p on p.rec_id = qc.person_id

    INNER JOIN [prod_ediybs_replica].[prod].[program_plans] as pp on q.quote_program_id = pp.program_id
    left JOIN [prod_ediybs_replica].[prod].[plan] as pl on pl.rec_id = pp.plan_id

	group by eg.rec_id,
    eg.[group_name],
    pl.[rec_id],
    gqpd.[surplus_option],
    o.[opportunity_name],
    o.[rec_id],
    c.rec_id,
    CASE 
        WHEN o.[opportunity_name] LIKE '%(R)%' THEN 'Y'
        ELSE 'N'
    END,
    es.status_name,
    tpa.[tpa_name],
    eg.[policy_id],
    q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name'),
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
    p.[coverage_election],
    gqpd.[au_factor_only_ee],
    gqpd.[au_factor_only_ec],
    gqpd.[au_factor_only_es],
    gqpd.[au_factor_only_ef],
    gqpd.[premium_factor_only_ee],
    gqpd.[premium_factor_only_ec],
    gqpd.[premium_factor_only_es],
    gqpd.[premium_factor_only_ef],
    gqpd.[carrier_markup_factor_only_ee],
    gqpd.[carrier_markup_factor_only_ec],
    gqpd.[carrier_markup_factor_only_es],
    gqpd.[carrier_markup_factor_only_ef],
    e.[art_who],
    e.[art_type],
    qe.[expense_amount]
)
select distinct
	rec_id as 'Ediybs Group ID', group_name as 'Group Name', plan_id as 'Plan ID', surplus_option as 'Surplus Option', opportunity_name as 'Opportunity Name', ediybs_id as 'Ediybs ID', 
	renewal_y_or_n as 'Renewal Y or N', ediybs_status as 'Ediybs Status', tpa_name as 'TPA Name', policy_id as 'Policy ID', quote_effective_date as 'Quote Effective Date', treaty_name as 'Treaty Name', 
	carrier_name as 'Carrier Name', network_name as 'Network Name', network_type as 'Network Type', ee_cencus as 'EE Cencus', es_cencus as 'ES Cencus', ec_cencus as 'EC Cencus', ef_cencus as 'EF Cencus', 
	ee_factor as 'EE Factor', es_factor as 'ES Factor', ec_factor as 'EC Factor', ef_factor as 'EF Factor', ee_prem as 'EE Prem', es_prem as 'ES Prem', ec_prem as 'EC Prem', ef_prem as 'EF Prem', 
	ee_carr_fee as 'EE Carr Fee', es_carr_fee as 'ES Carr Fee', ec_carr_fee as 'EC Carr Fee', ef_carr_fee as 'EF Carr Fee', 
    ((ee_prem * ee_cencus) + (ec_prem * ec_cencus) + (es_prem * es_cencus) + (ef_prem * ef_cencus)) as 'Total Premium Billed Per Plan',
    ADMN as 'ADMN', BADM as 'BADM', CAPM as 'CAPM', GA as 'GA', HCAR as 'HCAR', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMR as 'SMR', SMRF as 'SMRF', 
	TECH as 'TECH', LGTT as 'LGTT', RPTT as 'RPTT', total as 'Total Non Recievable Admin Fees'
from cte1
WHERE 
    treaty_id in (31,32) and quote_effective_date = '2024-04-01 00:00:00' and ediybs_status = 'Live' and renewal_y_or_n = 'Y' and surplus_option = '0'
order by group_name
;


-------------------------------------------------------------------------------------------------------------------------------------------------------

create proc GetFilteredData
	@quote_eff_date DATE,
    @ediybs_status varchar,
	@renewal_option varchar,
	@surplus_option varchar
AS
BEGIN
with cte1 as(
SELECT distinct
	eg.rec_id,
    eg.[group_name],
    pl.[rec_id] as plan_id,
	gqpd.[surplus_option],
    o.[opportunity_name],
    o.[rec_id] as 'ediybs_id',
    c.rec_id as treaty_id,
	case 
		when o.[opportunity_name] like '%(R)%' then 'Y'
		else 'N'
	end as renewal_y_or_n,
	es.status_name as ediybs_status,
	tpa.[tpa_name],
	eg.[policy_id],
	q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name') as treaty_name,
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
	case 
			when p.[coverage_election] = 'EE'  then  count(p.[coverage_election])
			else ''
		end as ee_cencus,
        case 
			when p.[coverage_election] = 'ES' then  count(p.[coverage_election])
			else ''
		end as es_cencus,
        case 
			when p.[coverage_election] = 'EC' then  count(p.[coverage_election])
			else ''
		end as ec_cencus,
        case 
			when p.[coverage_election] = 'EF' then  count(p.[coverage_election])
			else ''
		end as ef_cencus,
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
    case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'ADMN' then  cast(qe.[expense_amount] as float)
        else ''
	  end as ADMN,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'BADM' then  cast(qe.[expense_amount] as float)
        else ''
	  end as BADM,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'CAPM' then  cast(qe.[expense_amount] as float)
        else ''
	  end as CAPM,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'GA' then  cast(qe.[expense_amount] as float)
        else ''
	  end as GA,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'HCAR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as HCAR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'HCRD' then  cast(qe.[expense_amount] as float)
        else ''
	  end as HCRD,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'MKTF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as MKTF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'NETF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as NETF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'OTHR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as OTHR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'RPRF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as RPRF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'SMR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as SMR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'SMRF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as SMRF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'TECH' then  cast(qe.[expense_amount] as float)
        else ''
	  end as TECH,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'LGTT' then  cast(qe.[expense_amount] as float)
        else ''
	  end as LGTT,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'RPTT' then  cast(qe.[expense_amount] as float)
        else ''
	  end as RPTT,
	  case 
		when e.art_who != 'SMR' and e.art_type like '%ADMN%' and e.art_type like '%BADM%' and e.art_type like '%CAPM%' and e.art_type like '%GA%' and e.art_type like '%HCRD%' and e.art_type like '%MKTF%' and e.art_type like '%NETF%' and e.art_type like '%OTHR%' and e.art_type like '%RPRF%' and e.art_type like '%SMR%' and e.art_type like '%SMRF%' and e.art_type like '%TECH%' and e.art_type like '%LGTT%' and e.art_type like '%RPTT%' then  sum(cast(qe.[expense_amount] as float))
        else ''
	  end as total
FROM 
    [prod_ediybs_replica].[prod].[quote] as q
    left JOIN [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd on q.rec_id = gqpd.quote_id
    left JOIN [prod_ediybs_replica].[prod].[carrier] as c on c.rec_id = q.quote_carrier_id
    left JOIN [prod_ediybs_replica].[prod].[network] as n on n.rec_id =  q.quote_network_id
	inner JOIN [prod_ediybs_replica].[prod].[quote_surplus_option] as qso on qso.quote_id = gqpd.quote_id

    left JOIN [prod_ediybs_replica].[prod].[opportunity] as o on o.rec_id = q.opportunity_id
    /*left JOIN [prod_ediybs_replica].[prod].[opportunity_notes] as o_notes on o.rec_id = o_notes.opportunity_id*/
    left JOIN [prod_ediybs_replica].[prod].[ediybs_group] as eg on eg.rec_id = o.group_id
	inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id

    left JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
    left JOIN [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id

    left JOIN [prod_ediybs_replica].[prod].[quote_expenses] as qe on q.rec_id = qe.quote_id
    left JOIN [prod_ediybs_replica].[prod].[expenses] as e on e.rec_id = qe.expense_id

    left JOIN [prod_ediybs_replica].[prod].[quote_census] as qc on q.rec_id = qc.quote_id
    left JOIN [prod_ediybs_replica].[prod].[person] as p on p.rec_id = qc.person_id

    INNER JOIN [prod_ediybs_replica].[prod].[program_plans] as pp on q.quote_program_id = pp.program_id
    left JOIN [prod_ediybs_replica].[prod].[plan] as pl on pl.rec_id = pp.plan_id

	group by eg.rec_id,
    eg.[group_name],
    pl.[rec_id],
    gqpd.[surplus_option],
    o.[opportunity_name],
    o.[rec_id],
    c.rec_id,
    CASE 
        WHEN o.[opportunity_name] LIKE '%(R)%' THEN 'Y'
        ELSE 'N'
    END,
    es.status_name,
    tpa.[tpa_name],
    eg.[policy_id],
    q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name'),
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
    p.[coverage_election],
    gqpd.[au_factor_only_ee],
    gqpd.[au_factor_only_ec],
    gqpd.[au_factor_only_es],
    gqpd.[au_factor_only_ef],
    gqpd.[premium_factor_only_ee],
    gqpd.[premium_factor_only_ec],
    gqpd.[premium_factor_only_es],
    gqpd.[premium_factor_only_ef],
    gqpd.[carrier_markup_factor_only_ee],
    gqpd.[carrier_markup_factor_only_ec],
    gqpd.[carrier_markup_factor_only_es],
    gqpd.[carrier_markup_factor_only_ef],
    e.[art_who],
    e.[art_type],
    qe.[expense_amount]
)
select distinct
	rec_id as 'Ediybs Group ID', group_name as 'Group Name', plan_id as 'Plan ID', surplus_option as 'Surplus Option', opportunity_name as 'Opportunity Name', ediybs_id as 'Ediybs ID', 
	renewal_y_or_n as 'Renewal Y or N', ediybs_status as 'Ediybs Status', tpa_name as 'TPA Name', policy_id as 'Policy ID', quote_effective_date as 'Quote Effective Date', treaty_name as 'Treaty Name', 
	carrier_name as 'Carrier Name', network_name as 'Network Name', network_type as 'Network Type', ee_cencus as 'EE Cencus', es_cencus as 'ES Cencus', ec_cencus as 'EC Cencus', ef_cencus as 'EF Cencus', 
	ee_factor as 'EE Factor', es_factor as 'ES Factor', ec_factor as 'EC Factor', ef_factor as 'EF Factor', ee_prem as 'EE Prem', es_prem as 'ES Prem', ec_prem as 'EC Prem', ef_prem as 'EF Prem', 
	ee_carr_fee as 'EE Carr Fee', es_carr_fee as 'ES Carr Fee', ec_carr_fee as 'EC Carr Fee', ef_carr_fee as 'EF Carr Fee', 
    ((ee_prem * ee_cencus) + (ec_prem * ec_cencus) + (es_prem * es_cencus) + (ef_prem * ef_cencus)) as 'Total Premium Billed Per Plan',
    ADMN as 'ADMN', BADM as 'BADM', CAPM as 'CAPM', GA as 'GA', HCAR as 'HCAR', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMR as 'SMR', SMRF as 'SMRF', 
	TECH as 'TECH', LGTT as 'LGTT', RPTT as 'RPTT', total as 'Total Non Recievable Admin Fees'
from cte1
WHERE 
    treaty_id in (31,32)  and 
	(quote_effective_date like @quote_eff_date or @quote_eff_date is null) and 
	(ediybs_status like @ediybs_status or @ediybs_status is null) and 
	(renewal_y_or_n like @renewal_option or renewal_y_or_n is null) and 
	(surplus_option like @surplus_option or @surplus_option is null)
order by group_name
END;


USE prod_ediybs_replica
GO
call dbo.GetFilteredData @quote_eff_date = N'2023-08-01 00:00:00', 
					@ediybs_status = N'Live', 
					@renewal_option = N'Y', 
					@surplus_option = N'0';
GO 

-------------------------------------------------------------------------------------------------------------------------------------------

 select distinct cast(q.[quote_effective_date] as date) quote_eff_date

from [prod_ediybs_replica].[prod].[quote] as q
inner JOIN [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd on q.rec_id = gqpd.quote_id
inner JOIN [prod_ediybs_replica].[prod].[opportunity] as o on o.rec_id = q.opportunity_id
inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id

where es.status_name = 'Live' and case 
	when o.[opportunity_name] like '%(R)%' then 'Y'
                else 'N'
end = 'Y' and gqpd.surplus_option = '0'
order by cast(q.[quote_effective_date] as date); 


------------------------------------------------------------------------------------------------------------------------------------------



with cte as(
			SELECT 
      [quote_id]
      ,[plan_id]
      ,[surplus_option]
      ,[au_factor_only_ee]
      ,[au_factor_only_ec]
      ,[au_factor_only_es]
      ,[au_factor_only_ef]
      ,[premium_factor_only_ee]
      ,[premium_factor_only_ec]
      ,[premium_factor_only_es]
      ,[premium_factor_only_ef]
      ,[carrier_markup_factor_only_ee]
      ,[carrier_markup_factor_only_ec]
      ,[carrier_markup_factor_only_es]
      ,[carrier_markup_factor_only_ef]

  FROM [prod_ediybs_replica].[prod].[generated_quote_plan_details]
  )


SELECT distinct
	eg.rec_id,
    eg.[group_name],
    cte.quote_id,
    cte.[plan_id] as plan_id,
	cte.[surplus_option],
    o.[opportunity_name],
    o.[rec_id] as 'ediybs_id',
    c.rec_id as treaty_id,
	case 
		when o.[opportunity_name] like '%(R)%' then 'Y'
		else 'N'
	end as renewal_y_or_n,
	es.status_name as ediybs_status,
	tpa.[tpa_name],
	eg.[policy_id],
	q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name') as treaty_name,
    c.[carrier_name],
    n.[network_name],
    n.[network_type]/*,
	case 
			when p.[coverage_election] = 'EE'  then  count(p.[coverage_election])
			else ''
		end as ee_cencus,
        case 
			when p.[coverage_election] = 'ES' then  count(p.[coverage_election])
			else ''
		end as es_cencus,
        case 
			when p.[coverage_election] = 'EC' then  count(p.[coverage_election])
			else ''
		end as ec_cencus,
        case 
			when p.[coverage_election] = 'EF' then  count(p.[coverage_election])
			else ''
	end as ef_cencus*/,
	q.opportunity_id,
	--ROW_NUMBER() OVER (PARTITION BY pl.[rec_id], qso.[surplus_option] ORDER BY pl.[rec_id], qso.[surplus_option]) AS row_no,
    cast(cte.[au_factor_only_ee] as float) as ee_factor,
    cast(cte.[au_factor_only_ec] as float) as ec_factor,
    cast(cte.[au_factor_only_es] as float) as es_factor,
    cast(cte.[au_factor_only_ef] as float) as ef_factor,
    cast(cte.[premium_factor_only_ee] as float) as ee_prem,
    cast(cte.[premium_factor_only_ec] as float) as ec_prem,
    cast(cte.[premium_factor_only_es] as float) as es_prem,
    cast(cte.[premium_factor_only_ef] as float) as ef_prem,
    cast(cte.[carrier_markup_factor_only_ee] as float) as ee_carr_fee,
    cast(cte.[carrier_markup_factor_only_ec] as float)ec_carr_fee,
    cast(cte.[carrier_markup_factor_only_es] as float) as es_carr_fee,
    cast(cte.[carrier_markup_factor_only_ef] as float)ef_carr_fee,
	--e.[art_who],
    --e.[art_type],
    cast(qe.[expense_amount] as float) expense_amount/*,
    case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'ADMN' then  cast(qe.[expense_amount] as float)
        else ''
	  end as ADMN,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'BADM' then  cast(qe.[expense_amount] as float)
        else ''
	  end as BADM,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'CAPM' then  cast(qe.[expense_amount] as float)
        else ''
	  end as CAPM,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'GA' then  cast(qe.[expense_amount] as float)
        else ''
	  end as GA,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'HCAR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as HCAR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'HCRD' then  cast(qe.[expense_amount] as float)
        else ''
	  end as HCRD,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'MKTF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as MKTF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'NETF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as NETF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'OTHR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as OTHR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'RPRF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as RPRF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'SMR' then  cast(qe.[expense_amount] as float)
        else ''
	  end as SMR,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'SMRF' then  cast(qe.[expense_amount] as float)
        else ''
	  end as SMRF,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'TECH' then  cast(qe.[expense_amount] as float)
        else ''
	  end as TECH,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'LGTT' then  cast(qe.[expense_amount] as float)
        else ''
	  end as LGTT,
      case 
		when e.[art_who] = 'SMR' and e.[art_type] = 'RPTT' then  cast(qe.[expense_amount] as float)
        else ''
	  end as RPTT,
	  case 
		when e.art_who != 'SMR' and e.art_type like '%ADMN%' and e.art_type like '%BADM%' and e.art_type like '%CAPM%' and e.art_type like '%GA%' and e.art_type like '%HCRD%' and e.art_type like '%MKTF%' and e.art_type like '%NETF%' and e.art_type like '%OTHR%' and e.art_type like '%RPRF%' and e.art_type like '%SMR%' and e.art_type like '%SMRF%' and e.art_type like '%TECH%' and e.art_type like '%LGTT%' and e.art_type like '%RPTT%' then  sum(cast(qe.[expense_amount] as float))
        else ''
	  end as total*/
FROM 
    [prod_ediybs_replica].[prod].[quote] as q
    inner join cte on q.rec_id = cte.quote_id
    inner JOIN [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd on q.rec_id = gqpd.quote_id
    inner JOIN [prod_ediybs_replica].[prod].[carrier] as c on c.rec_id = q.quote_carrier_id
    inner JOIN [prod_ediybs_replica].[prod].[network] as n on n.rec_id =  q.quote_network_id
	inner JOIN [prod_ediybs_replica].[prod].[quote_surplus_option] as qso on qso.quote_id = gqpd.quote_id

    inner JOIN [prod_ediybs_replica].[prod].[opportunity] as o on o.rec_id = q.opportunity_id
    /*left JOIN [prod_ediybs_replica].[prod].[opportunity_notes] as o_notes on o.rec_id = o_notes.opportunity_id*/
    inner JOIN [prod_ediybs_replica].[prod].[ediybs_group] as eg on eg.rec_id = o.group_id
	inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id

    inner JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
    inner JOIN [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id

    inner JOIN [prod_ediybs_replica].[prod].[quote_expenses] as qe on q.rec_id = qe.quote_id
    inner JOIN [prod_ediybs_replica].[prod].[expenses] as e on e.rec_id = qe.expense_id

    inner JOIN [prod_ediybs_replica].[prod].[quote_census] as qc on q.rec_id = qc.quote_id
    inner JOIN [prod_ediybs_replica].[prod].[person] as p on p.rec_id = qc.person_id

    INNER JOIN [prod_ediybs_replica].[prod].[program_plans] as pp on q.quote_program_id = pp.program_id
    inner JOIN [prod_ediybs_replica].[prod].[plan] as pl on pl.rec_id = pp.plan_id

	WHERE 
    c.rec_id in (31,32) and opportunity_name = 'Robinson Aviation Inc (R) 2023' and cte.quote_id = 7707 

	group by eg.rec_id,
    eg.[group_name],
    cte.quote_id,
    cte.[plan_id],
	cte.[surplus_option],
    o.[opportunity_name],
    o.[rec_id],
    c.rec_id,
    CASE 
        WHEN o.[opportunity_name] LIKE '%(R)%' THEN 'Y'
        ELSE 'N'
    END,
    es.status_name,
    tpa.[tpa_name],
    eg.[policy_id],
    q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name'),
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
    --p.[coverage_election],
	q.opportunity_id,
    cte.[au_factor_only_ee],
    cte.[au_factor_only_ec],
    cte.[au_factor_only_es],
    cte.[au_factor_only_ef],
    cte.[premium_factor_only_ee],
    cte.[premium_factor_only_ec],
    cte.[premium_factor_only_es],
    cte.[premium_factor_only_ef],
    cte.[carrier_markup_factor_only_ee],
    cte.[carrier_markup_factor_only_ec],
    cte.[carrier_markup_factor_only_es],
    cte.[carrier_markup_factor_only_ef],
   -- e.[art_who],
   -- e.[art_type],
    qe.[expense_amount]
	order by plan_id,surplus_option
)
select distinct
	rec_id as 'Ediybs Group ID', group_name as 'Group Name', plan_id as 'Plan ID', surplus_option as 'Surplus Option', opportunity_name as 'Opportunity Name', ediybs_id as 'Ediybs ID', 
	renewal_y_or_n as 'Renewal Y or N', ediybs_status as 'Ediybs Status', tpa_name as 'TPA Name', policy_id as 'Policy ID', quote_effective_date as 'Quote Effective Date', treaty_name as 'Treaty Name', 
	carrier_name as 'Carrier Name', network_name as 'Network Name', network_type as 'Network Type'/*, ee_cencus as 'EE Cencus', es_cencus as 'ES Cencus', ec_cencus as 'EC Cencus', ef_cencus as 'EF Cencus'*/, opportunity_id,
	ee_factor as 'EE Factor', es_factor as 'ES Factor', ec_factor as 'EC Factor', ef_factor as 'EF Factor', ee_prem as 'EE Prem', es_prem as 'ES Prem', ec_prem as 'EC Prem', ef_prem as 'EF Prem', 
	ee_carr_fee as 'EE Carr Fee', es_carr_fee as 'ES Carr Fee', ec_carr_fee as 'EC Carr Fee', ef_carr_fee as 'EF Carr Fee'/*, 
    ((ee_prem * ee_cencus) + (ec_prem * ec_cencus) + (es_prem * es_cencus) + (ef_prem * ef_cencus)) as 'Total Premium Billed Per Plan',
    ADMN as 'ADMN', BADM as 'BADM', CAPM as 'CAPM', GA as 'GA', HCAR as 'HCAR', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMR as 'SMR', SMRF as 'SMRF', 
	TECH as 'TECH', LGTT as 'LGTT', RPTT as 'RPTT', total as 'Total Non Recievable Admin Fees'*/
from cte1
WHERE 
    treaty_id in (31,32) and opportunity_name = 'Robinson Aviation Inc (R) 2023' 
order by plan_id,surplus_option;

-- quote.opportunity_id/quote_name


-- EDIYBS
SELECT
    q.rec_id AS Quote_ID,
    q.opportunity_id AS Opportunity_ID,
    o.opportunity_name AS Opportunity_name,
    eg.group_name AS Group_Name,
    eg.group_sic_code AS SIC_Code,
    p.program_name AS Sales_Program,
    q.uw_factor_used AS Risk_Score,
    q.quote_effective_date AS Quote_Effective_Date,
    q.quote_name AS Quote_Name,
    eg.group_state AS Quote_State,
    COUNT(CASE WHEN per.person_relationship_code = 1 THEN 1 END) AS Total_EE_Lives,
    CASE WHEN q.quote_status = 1 THEN 'Contingent' ELSE 'Final' END AS Quote_Status,
    q.creation_date AS Create_Date,
    n.network_name AS Network,
    car.carrier_name AS Carrier,
    CASE WHEN q.quote_selected = 1 THEN 'Ran and bought' ELSE 'Ran but not bought' END AS Selected_Quote,
    CASE WHEN q.is_active = 1 THEN 'Active' ELSE 'Deleted' END AS Is_Active,
    tpa.tpa_name AS TPA_Name,
    ag.agency_name AS Agency_Name,
    b.broker_contact_name AS Broker_Name
FROM
    [prod_ediybs_replica].[prod].[quote] AS q
JOIN
    [prod_ediybs_replica].[prod].[opportunity] AS o ON q.opportunity_id = o.rec_id
JOIN
    [prod_ediybs_replica].[prod].[ediybs_group] AS eg ON o.group_id = eg.rec_id
JOIN
    [prod_ediybs_replica].[prod].[program] AS p ON q.quote_program_id = p.rec_id
JOIN
    [prod_ediybs_replica].[prod].[network] AS n ON q.quote_network_id = n.rec_id
JOIN
    [prod_ediybs_replica].[prod].[carrier] AS car ON q.quote_carrier_id = car.rec_id
JOIN
    [prod_ediybs_replica].[prod].[tpa] AS tpa ON p.tpa_id = tpa.rec_id
JOIN
    [prod_ediybs_replica].[prod].[broker] AS b ON q.broker_id = b.rec_id
JOIN
    [prod_ediybs_replica].[prod].[agency] AS ag ON b.broker_agency_id = ag.rec_id
/*LEFT*/ JOIN
    [prod_ediybs_replica].[prod].[quote_census] AS qc ON q.rec_id = qc.quote_id
/*LEFT*/ JOIN
    [prod_ediybs_replica].[prod].[person] AS per ON qc.person_id = per.rec_id
GROUP BY
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
    car.carrier_name,
    q.quote_selected,
    q.is_active,
    tpa.tpa_name,
    ag.agency_name,
    b.broker_contact_name
ORDER BY 
q.quote_effective_date desc;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- ediybs
-- left anti join
with table_1 as (SELECT
    q.rec_id AS Quote_ID,
    q.opportunity_id AS Opportunity_ID,
    o.opportunity_name AS Opportunity_name,
    eg.group_name AS Group_Name,
    eg.group_sic_code AS SIC_Code,
    p.program_name AS Sales_Program,
    q.uw_factor_used AS Risk_Score,
    q.quote_effective_date AS Quote_Effective_Date,
    q.quote_name AS Quote_Name,
    eg.group_state AS Quote_State,
    COUNT(CASE WHEN per.person_relationship_code = 1 THEN 1 END) AS Total_EE_Lives,
    CASE WHEN q.quote_status = 1 THEN 'Contingent' ELSE 'Final' END AS Quote_Status,
    q.creation_date AS Create_Date,
    n.network_name AS Network,
    car.carrier_name AS Carrier,
    CASE WHEN q.quote_selected = 1 THEN 'Ran and bought' ELSE 'Ran but not bought' END AS Selected_Quote,
    CASE WHEN q.is_active = 1 THEN 'Active' ELSE 'Deleted' END AS Is_Active,
    tpa.tpa_name AS TPA_Name,
    ag.agency_name AS Agency_Name,
    b.broker_contact_name AS Broker_Name
FROM
    [prod_ediybs_replica].[prod].[quote] AS q
JOIN
    [prod_ediybs_replica].[prod].[opportunity] AS o ON q.opportunity_id = o.rec_id
JOIN
    [prod_ediybs_replica].[prod].[ediybs_group] AS eg ON o.group_id = eg.rec_id
JOIN
    [prod_ediybs_replica].[prod].[program] AS p ON q.quote_program_id = p.rec_id
JOIN
    [prod_ediybs_replica].[prod].[network] AS n ON q.quote_network_id = n.rec_id
JOIN
    [prod_ediybs_replica].[prod].[carrier] AS car ON q.quote_carrier_id = car.rec_id
JOIN
    [prod_ediybs_replica].[prod].[tpa] AS tpa ON p.tpa_id = tpa.rec_id
JOIN
    [prod_ediybs_replica].[prod].[broker] AS b ON q.broker_id = b.rec_id
JOIN
    [prod_ediybs_replica].[prod].[agency] AS ag ON b.broker_agency_id = ag.rec_id
left JOIN
    [prod_ediybs_replica].[prod].[quote_census] AS qc ON q.rec_id = qc.quote_id
left JOIN
    [prod_ediybs_replica].[prod].[person] AS per ON qc.person_id = per.rec_id
GROUP BY
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
    car.carrier_name,
    q.quote_selected,
    q.is_active,
    tpa.tpa_name,
    ag.agency_name,
    b.broker_contact_name
), 

table_2 as (SELECT
    q.rec_id AS Quote_ID,
    q.opportunity_id AS Opportunity_ID,
    o.opportunity_name AS Opportunity_name,
    eg.group_name AS Group_Name,
    eg.group_sic_code AS SIC_Code,
    p.program_name AS Sales_Program,
    q.uw_factor_used AS Risk_Score,
    q.quote_effective_date AS Quote_Effective_Date,
    q.quote_name AS Quote_Name,
    eg.group_state AS Quote_State,
    COUNT(CASE WHEN per.person_relationship_code = 1 THEN 1 END) AS Total_EE_Lives,
    CASE WHEN q.quote_status = 1 THEN 'Contingent' ELSE 'Final' END AS Quote_Status,
    q.creation_date AS Create_Date,
    n.network_name AS Network,
    car.carrier_name AS Carrier,
    CASE WHEN q.quote_selected = 1 THEN 'Ran and bought' ELSE 'Ran but not bought' END AS Selected_Quote,
    CASE WHEN q.is_active = 1 THEN 'Active' ELSE 'Deleted' END AS Is_Active,
    tpa.tpa_name AS TPA_Name,
    ag.agency_name AS Agency_Name,
    b.broker_contact_name AS Broker_Name
FROM
    [prod_ediybs_replica].[prod].[quote] AS q
JOIN
    [prod_ediybs_replica].[prod].[opportunity] AS o ON q.opportunity_id = o.rec_id
JOIN
    [prod_ediybs_replica].[prod].[ediybs_group] AS eg ON o.group_id = eg.rec_id
JOIN
    [prod_ediybs_replica].[prod].[program] AS p ON q.quote_program_id = p.rec_id
JOIN
    [prod_ediybs_replica].[prod].[network] AS n ON q.quote_network_id = n.rec_id
JOIN
    [prod_ediybs_replica].[prod].[carrier] AS car ON q.quote_carrier_id = car.rec_id
JOIN
    [prod_ediybs_replica].[prod].[tpa] AS tpa ON p.tpa_id = tpa.rec_id
JOIN
    [prod_ediybs_replica].[prod].[broker] AS b ON q.broker_id = b.rec_id
JOIN
    [prod_ediybs_replica].[prod].[agency] AS ag ON b.broker_agency_id = ag.rec_id
JOIN
    [prod_ediybs_replica].[prod].[quote_census] AS qc ON q.rec_id = qc.quote_id
JOIN
    [prod_ediybs_replica].[prod].[person] AS per ON qc.person_id = per.rec_id
GROUP BY
    q.rec_id, q.opportunity_id, eg.group_name, eg.group_sic_code, o.opportunity_name, p.program_name, q.uw_factor_used, q.quote_effective_date,
    q.quote_name, eg.group_state, q.creation_date, n.network_name, q.quote_status, car.carrier_name, q.quote_selected, q.is_active, tpa.tpa_name,
    ag.agency_name, b.broker_contact_name
)
SELECT * FROM Table_1 t1 LEFT JOIN Table_2 t2 ON t1.Quote_ID = t2.Quote_ID WHERE t2.Quote_ID IS NULL;

----------------------------------------------------------------------------------------------------------------------------------------------------

-- large group count
select meme.meme_grpn, count(mem.mem_id1)
from 
	SSRS_visova.hit_vaas_test.mem as mem
inner join 
	SSRS_visova.hit_vaas_test.meme as meme on mem.mem_id1 = meme.meme_id1
group by meme_grpn
order by count(mem.mem_id1) desc;

---------------------------------------------------------------------------------------------------------------------------------------
-- visova member & client report
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
    meme.meme_depc,
    valid.val_desc,
	ROW_NUMBER() over (partition by mem.mem_id1, meme.meme_id2 order by mem.mem_id1) as row_no
from 
	SSRS_visova.hit_vaas_test.mem as mem
inner join 
	SSRS_visova.hit_vaas_test.meme as meme on mem.mem_id1 = meme.meme_id1
left join 
	SSRS_visova.hit_vaas_test.clip as clip on meme.meme_clir = clip.clip_id1 
inner join 
	SSRS_visova.hit_vaas_test.cli as cli on cli.cli_id1 = clip.clip_id1
inner join
	SSRS_visova.hit_vaas_test.valid as valid on meme.meme_plan = valid.val_code
	)

select 
	mem_id1 as "Member ID", 
    meme_id2 as "Member Plan Year", 
    mem_essn as "Family ID", 
    mem_lname as "Last Name", 
    mem_fname as "First Name", 
    mem_rel as "Relationship", 
    meme_clir as "Client ID", 
    mem_sex as "Gender", 
    mem_state as "State", 
    mem_zip as "Zip", 
    meme_lev1 as "Selection Criteria 1", 
    meme_lev2 as "TPA", 
    meme_lev3 as "Selection Criteria 3", 
    meme_grpn as "Group Name", 
    mem_dob as "Selection_Criteria_3", 
    clip_eff as "Plan Effective Date", 
    meme_eff as "Member Effective Date", 
    meme_trm as "Member Term Date", 
    meme_net as "Network", 
    meme_prd as "PPO/RBP", 
    meme_carr as "Carrier", 
    val_desc as "Plan Name", 
    meme_depc as "Dependent Coverage"
from 
	cte
where row_no = 1
group by 
	mem_id1, meme_id2, mem_essn, meme_clir, mem_state, meme_net, meme_prd, meme_carr, val_desc, mem_rel, mem_sex, mem_zip, 
	meme_lev1, meme_lev2, meme_lev3, meme_grpn, mem_dob, clip_eff, meme_eff,meme_trm, meme_depc, mem_lname, mem_fname
order by 
	mem_id1
;    
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- visova enrollment report parameters

-- prm_test_group
/*select distinct meme_grpn
from [SSRS_visova].[hit_vaas_test].[meme]
ORDER BY meme_grpn;
*/

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
	),
	cte1 as(

select  
    meme_grpn
from 
	cte
where row_no = 1 and val_type = '529'
group by 
	mem_lname, mem_fname, mem_rel, meme_depc, mem_essn, mem_sex, mem_state, mem_zip, clip_eff, clip_trm, meme_eff, meme_trm, meme_grpn, meme_lev2, val_desc, mem_dob
)
select distinct meme_grpn
from cte1
group by meme_grpn
;

/*
-- prm_tpa
select distinct meme_lev2
from [SSRS_visova].[hit_vaas_test].[meme]
where meme_grpn = @test_group;
*/

-- prm_plan_effective_date
select 
         distinct clip.clip_eff
from 
         [SSRS_visova].[hit_vaas_test].[meme] as meme
left join 
         SSRS_visova.hit_vaas_test.clip as clip on meme.meme_clir = clip.clip_id1 and meme.meme_plan = clip.clip_plan
where meme_grpn = @test_group;

-- prm_plan_termination_date
select 
         distinct clip.clip_trm
from 
         [SSRS_visova].[hit_vaas_test].[meme] as meme
left join 
         SSRS_visova.hit_vaas_test.clip as clip on meme.meme_clir = clip.clip_id1 and meme.meme_plan = clip.clip_plan
where meme.meme_grpn = @test_group 
    and clip.clip_eff in (@plan_effective_date);
--------------------------------------------------------------------------------------------------------------------------------------

-- visova enrollment report - table

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
where  val_type = '529' 
group by 
	mem_lname, mem_fname, mem_rel, meme_depc, mem_essn, mem_sex, mem_state, mem_zip, clip_eff, clip_trm, meme_eff, meme_trm, meme_grpn, meme_lev2, val_desc, mem_dob
order by
	mem_fname
;

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- visova enrollment- matrix report

WITH cte AS (
    SELECT 
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
where cast(StartOfMonth as date) <= EOMONTH(GETDATE(), -1) and val_type = '529'and (tier is not null and tier != '') 
group by 
	mem_lname, mem_fname, mem_rel, tier, mem_essn, mem_sex, mem_state, mem_zip, clip_eff, clip_trm, meme_eff, meme_trm, StartOfMonth, meme_grpn, meme_lev2, val_desc, mem_dob
order by mem_fname
;

----------------------------------------------------------------------------------------------------------------------------------------------------                        
-- person_details from ediybs
SELECT pers.[rec_id]
      ,[person_first_name] AS 'FIRST NAME'
      ,[person_last_name]AS 'LAST NAME'
      ,[person_addr1]AS 'ADDRESS'
      ,[person_city]AS 'CITY'
      ,[person_state]AS 'STATE'
      ,[person_zip]AS 'ZIP'
      ,[person_gender]AS 'GENDER'
      ,pers.[is_active]AS 'IS ACTIVE'
      ,medcon.[medical_condition_onset_date]AS 'Medical Condition Onset Date'
      ,medcon.[medical_condition_end_date]AS 'Medical Condition End Date'
      ,medcon.[medical_condition_notes]AS 'Medical Condition Notes'
      ,healthnote.[health_app_note]AS 'Health App Notes'
      ,[ageSexFactor]AS 'Age-Sex-Factor'
      ,[areaFactor]AS 'Area Factor'
      ,[verakai_risk_score]AS 'Verakai Risk Score'
      ,riskscprov.[risk_score_provider_description]AS 'Risk Score Provider'
      ,risksc.[risk_score]AS 'Risk Score'
      ,[person_relationship_code]AS 'Relationship'
      ,[person_family_id]AS 'Family Id'
      ,[person_age]AS 'Age'
      ,[person_nha]AS '_nha'
  FROM [prod_ediybs_replica].[prod].[person] AS pers 

LEFT JOIN [prod_ediybs_replica].[prod].[person_medical_condition] AS medcon ON  pers.rec_id = medcon.person_id

LEFT JOIN [prod_ediybs_replica].[prod].[person_risk_score] AS risksc ON  pers.rec_id = risksc.person_id

LEFT JOIN [prod_ediybs_replica].[prod].[person_health_app_notes] AS healthnote ON  pers.rec_id = healthnote.person_id

LEFT JOIN [prod_ediybs_replica].[prod].[risk_score_provider] AS riskscprov ON  risksc.risk_score_provider_id = riskscprov.rec_id;



-----------------------------------------------------------------------------------------------------------------------------
-- eDIYBS Opportunity Reports parameters

-- surplus_option
select distinct gqpd.[surplus_option]
from [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd;

---------------------------------------------

-- ediybs_status
select distinct es.[status_name] 
from [prod_ediybs_replica].[prod].[ediybs_status] as es
inner join [prod_ediybs_replica].[prod].[opportunity] as o on o.opportunity_status_id = es.rec_id
order by es.[status_name];

-----------------------------------------

-- renewal
select distinct 
				case 
					when o.[opportunity_name] like '%(R)%' then 'Y'
					else 'N'
				end as renewal_y_or_n
from [prod_ediybs_replica].[prod].[opportunity] as o
inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id
where es.status_name in (@status_name) ;

-------------------------------------------------

-- opportunity_name
select distinct o.opportunity_name
from [prod_ediybs_replica].[prod].[opportunity] as o
inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id
inner JOIN [prod_ediybs_replica].[prod].[quote] as q on o.rec_id = q.opportunity_id
inner JOIN [prod_ediybs_replica].[prod].[carrier] as c on c.rec_id = q.quote_carrier_id
WHERE 
    c.rec_id in (31,32) and quote_selected = 1 and es.status_name in (@status_name) and  
case 
	when o.[opportunity_name] like '%(R)%' then 'Y'
	else 'N'
end in (@renewal_y_or_n)
order by o.opportunity_name;

--------------------------------------------------

-- tpa
select distinct tpa.[tpa_name] 
from [prod_ediybs_replica].[prod].[tpa] as tpa 
inner JOIN [prod_ediybs_replica].[prod].[program] as prg on tpa.rec_id = prg.tpa_id
inner JOIN [prod_ediybs_replica].[prod].[quote] as q on  prg.rec_id = q.quote_program_id
inner join[prod_ediybs_replica].[prod].[opportunity] as o on q.opportunity_id = o.rec_id 
inner JOIN [prod_ediybs_replica].[prod].[carrier] as c on c.rec_id = q.quote_carrier_id
inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id

where c.rec_id in (31,32) and quote_selected = 1 and es.status_name in (@status_name) and  
case 
	when o.[opportunity_name] like '%(R)%' then 'Y'
	else 'N'
end in (@renewal_y_or_n) and o.opportunity_name in (@opportunity_name)
order by tpa.[tpa_name];

------------------------------------------------

-- quote_effective_date
select distinct cast(q.[quote_effective_date] as date) quote_eff_date
from [prod_ediybs_replica].[prod].[quote] as q
inner JOIN [prod_ediybs_replica].[prod].[carrier] as c on c.rec_id = q.quote_carrier_id
inner JOIN [prod_ediybs_replica].[prod].[opportunity] as o on o.rec_id = q.opportunity_id
inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id
inner JOIN [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd on q.rec_id = gqpd.quote_id
inner JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
inner join [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id
where c.rec_id in (31,32) and quote_selected = 1 and es.status_name in (@status_name) and  
case 
	when o.[opportunity_name] like '%(R)%' then 'Y'
	else 'N'
end in (@renewal_y_or_n) and o.opportunity_name in (@opportunity_name) and tpa.tpa_name in (@tpa_name) 
order by cast(q.[quote_effective_date] as date); 
-----------------------------------------------------------

----------------------------------------------------------------------------------------------------------------

-- eDIYBS Opportunity Reports
with cte4 as(
        select qe.quote_id, 
        SUM(case 
            when e.art_type in('ADMN', 'BADM', 'CAPM', 'GA', 'HCAR', 'HCRD', 'MKTF', 'NETF', 'OTHR', 'RPRF', 'SMR', 'SMRF', 'TECH', 'LGTT', 'RPTT') THEN CAST(qe.[expense_amount] as float)
            else 0 
        end) as total
        FROM 
            [prod_ediybs_replica].[prod].[expenses] AS e
        INNER JOIN 
            [prod_ediybs_replica].[prod].[quote_expenses] AS qe ON e.rec_id = qe.expense_id
        WHERE e.art_who <> 'SMR'
        GROUP BY 
            qe.quote_id
),
 
cte3 as(
    SELECT qe.quote_id,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'ADMN' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS ADMN,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'BADM' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS BADM,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'CAPM' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS CAPM,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'GA' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS GA,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'HCAR' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS HCAR,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'HCRD' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS HCRD,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'MKTF' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS MKTF,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'NETF' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS NETF,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'OTHR' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS OTHR,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'RPRF' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS RPRF,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'SMR' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS SMR,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'SMRF' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS SMRF,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'TECH' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS TECH,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'LGTT' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS LGTT,
    SUM(CASE 
            WHEN e.[art_who] = 'SMR' AND e.[art_type] = 'RPTT' THEN  CAST(qe.[expense_amount] AS FLOAT)
            ELSE 0
        END) AS RPTT
    FROM 
        [prod_ediybs_replica].[prod].[expenses] AS e
    INNER JOIN 
        [prod_ediybs_replica].[prod].[quote_expenses] AS qe ON e.rec_id = qe.expense_id
    GROUP BY 
        qe.quote_id
),

cte2 as(
    select p.[opportunity_id],
    sum(case 
        when p.[coverage_election] = 'EE'  then  1
        else 0
    end) as ee_cencus,
    sum(case 
        when p.[coverage_election] = 'ES' then  1
        else 0
    end) as es_cencus,
    sum(case 
        when p.[coverage_election] = 'EC' then  1
        else 0
    end) as ec_cencus,
    sum(case 
        when p.[coverage_election] = 'EF' then  1
        else 0
    end) as ef_cencus
    from 
        [prod_ediybs_replica].[prod].[person] as p
    group by 
        p.[opportunity_id]
),

cte1 as(
    SELECT distinct
    eg.rec_id,
    eg.[group_name],
    /*cte5.is_active,*/
    qp.is_active,
    gqpd.quote_id,
    gqpd.[plan_id],
    gqpd.[surplus_option],
    o.[opportunity_name],
    o.[rec_id] as 'ediybs_id',
    c.rec_id as treaty_id,
    case 
        when o.[opportunity_name] like '%(R)%' then 'Y'
        else 'N'
    end as renewal_y_or_n,
    es.status_name as ediybs_status,
    tpa.[tpa_name],
    eg.[policy_id],
    q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name') as treaty_name,
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
    cte2.ee_cencus,
    cte2.es_cencus,
    cte2.ec_cencus,
    cte2.ef_cencus,
    q.opportunity_id,
    q.quote_selected,
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
    cte4.total
FROM 
    [prod_ediybs_replica].[prod].[quote] as q
    inner JOIN [prod_ediybs_replica].[prod].[generated_quote_plan_details] as gqpd on q.rec_id = gqpd.quote_id
    inner JOIN [prod_ediybs_replica].[prod].[carrier] as c on c.rec_id = q.quote_carrier_id
    inner JOIN [prod_ediybs_replica].[prod].[network] as n on n.rec_id =  q.quote_network_id

    inner JOIN [prod_ediybs_replica].[prod].[opportunity] as o on o.rec_id = q.opportunity_id
    inner JOIN [prod_ediybs_replica].[prod].[ediybs_group] as eg on eg.rec_id = o.group_id
    inner join [prod_ediybs_replica].[prod].[ediybs_status] as es on o.opportunity_status_id = es.rec_id

    inner join cte2 on o.rec_id = cte2.opportunity_id
    inner join cte3 on q.rec_id = cte3.quote_id
    inner join cte4 on q.rec_id = cte4.quote_id

    inner JOIN [prod_ediybs_replica].[prod].[program] as prg on  prg.rec_id = q.quote_program_id
    inner JOIN [prod_ediybs_replica].[prod].[tpa] as tpa on tpa.rec_id = prg.tpa_id

    inner JOIN [prod_ediybs_replica].[prod].[quote_expenses] as qe on q.rec_id = qe.quote_id
    inner JOIN [prod_ediybs_replica].[prod].[expenses] as e on e.rec_id = qe.expense_id

    inner JOIN [prod_ediybs_replica].[prod].[quote_census] as qc on q.rec_id = qc.quote_id
    inner JOIN [prod_ediybs_replica].[prod].[person] as p on p.rec_id = qc.person_id
    INNER JOIN [prod_ediybs_replica].[prod].[quote_plans] as qp on qp.quote_id =gqpd.quote_id and qp.plan_id = gqpd.plan_id
    INNER JOIN [prod_ediybs_replica].[prod].[program_plans] as pp on q.quote_program_id = pp.program_id
    inner JOIN [prod_ediybs_replica].[prod].[plan] as pl on pl.rec_id = pp.plan_id
    /*and q.rec_id = qp.quote_id*/

    group by eg.rec_id,
    eg.[group_name],
    gqpd.quote_id,
    gqpd.[plan_id],
    gqpd.[surplus_option],
    o.[opportunity_name],
    o.[rec_id],
    c.rec_id,
    CASE 
        WHEN o.[opportunity_name] LIKE '%(R)%' THEN 'Y'
        ELSE 'N'
    END,
    es.status_name,
    tpa.[tpa_name],
    eg.[policy_id],
    q.[quote_effective_date],
    JSON_VALUE(c.[treaty_configuration_json],'$.treaty_name'),
    c.[carrier_name],
    n.[network_name],
    n.[network_type],
    cte2.ee_cencus,
    cte2.es_cencus,
    cte2.ec_cencus,
    cte2.ef_cencus,
    q.opportunity_id,
    q.quote_selected,
    gqpd.[au_factor_only_ee],
    gqpd.[au_factor_only_ec],
    gqpd.[au_factor_only_es],
    gqpd.[au_factor_only_ef],
    gqpd.[premium_factor_only_ee],
    gqpd.[premium_factor_only_ec],
    gqpd.[premium_factor_only_es],
    gqpd.[premium_factor_only_ef],
    gqpd.[carrier_markup_factor_only_ee],
    gqpd.[carrier_markup_factor_only_ec],
    gqpd.[carrier_markup_factor_only_es],
    gqpd.[carrier_markup_factor_only_ef],
    e.[art_who],
    e.[art_type],
    qe.[expense_amount],
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
    qp.is_active
)
select distinct
    quote_id, is_active, rec_id as 'eDIYBS Group ID', group_name as 'eDIYBS Group Name', plan_id as 'Plan ID', surplus_option as 'Surplus Option', opportunity_name as 'Opportunity Name', ediybs_id as 'eDIYBS ID', 
    renewal_y_or_n as 'Renewal Y or N', ediybs_status as 'eDIYBS Status', tpa_name as 'TPA Name', policy_id as 'Policy ID', quote_effective_date as 'Quote Effective Date', treaty_name as 'Treaty Name', 
    carrier_name as 'Carrier Name', network_name as 'Network Name', network_type as 'Network Type', ee_cencus as 'EE Cencus', es_cencus as 'ES Cencus', ec_cencus as 'EC Cencus', ef_cencus as 'EF Cencus', opportunity_id,
    ee_factor as 'EE Factor', es_factor as 'ES Factor', ec_factor as 'EC Factor', ef_factor as 'EF Factor', ee_prem as 'EE Prem', es_prem as 'ES Prem', ec_prem as 'EC Prem', ef_prem as 'EF Prem', 
    ee_carr_fee as 'EE Carr Fee', es_carr_fee as 'ES Carr Fee', ec_carr_fee as 'EC Carr Fee', ef_carr_fee as 'EF Carr Fee', 
    ((ee_prem * ee_cencus) + (ec_prem * ec_cencus) + (es_prem * es_cencus) + (ef_prem * ef_cencus)) as 'Total Premium Billed Per Plan',
    ADMN as 'ADMN', BADM as 'BADM', CAPM as 'CAPM', GA as 'GA', HCAR as 'HCAR', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMR as 'SMR', SMRF as 'SMRF', 
    TECH as 'TECH', LGTT as 'LGTT', RPTT as 'RPTT', total as 'Total Non Recievable Admin Fees'
from cte1
WHERE 
    treaty_id in (31,32) and quote_selected = 1 and opportunity_name in (@opportunity_name) and surplus_option in (@surplus_option) and tpa_name in (@tpa_name) and ediybs_status in (@status_name) and renewal_y_or_n in (@renewal_y_or_n) and quote_effective_date  in (@quote_effective_date )
order by plan_id;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### eDIYBS Opportunity Report: -

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
		p.[is_active] as person_is_active,
        o.opportunity_sic_code,
        o.roster_id
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
    /*quote_id, opportunity_id, rec_id as 'eDIYBS Group ID', group_name as 'eDIYBS Group Name', plan_id as 'Plan ID', surplus_option as 'Surplus Option', opportunity_name as 'Opportunity Name', ediybs_id as 'eDIYBS ID', 
    renewal_y_or_n as 'Renewal Y or N', ediybs_status as 'eDIYBS Status', tpa_name as 'TPA Name', policy_id as 'Policy ID', quote_effective_date as 'Quote Effective Date', treaty_name as 'Treaty Name', 
    carrier_name as 'Carrier Name', network_name as 'Network Name', network_type as 'Network Type', ee_census as 'EE Census', es_census as 'ES Census', ec_census as 'EC Cencus', ef_census as 'EF Census', 
    ee_factor as 'EE Factor', es_factor as 'ES Factor', ec_factor as 'EC Factor', ef_factor as 'EF Factor', ee_prem as 'EE Prem', es_prem as 'ES Prem', ec_prem as 'EC Prem', ef_prem as 'EF Prem', 
    ee_carr_fee as 'EE Carr Fee', es_carr_fee as 'ES Carr Fee', ec_carr_fee as 'EC Carr Fee', ef_carr_fee as 'EF Carr Fee', 
    ((ee_prem * ee_census) + (ec_prem * ec_census) + (es_prem * es_census) + (ef_prem * ef_census)) as 'Total Premium Billed Per Plan',
    ADMN as 'ADMN', BADM as 'BADM', CAPM as 'CAPM', GA as 'GA', HCAR as 'HCAR', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMR as 'SMR', SMRF as 'SMRF', 
    TECH as 'TECH', LGTT as 'LGTT', RPTT as 'RPTT', total as 'Total Non Recievable Admin Fees'
    */
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
    group_name as 'eDIYBS Group Name', opportunity_name as 'Opportunity Name', quote_effective_date as 'Quote Effective Date', network_name as 'Network Name', 
    ee_census as 'EE Census', es_census as 'ES Census', ec_census as 'EC Cencus', ef_census as 'EF Census', 
    opportunity_sic_code, policy_id as 'Policy ID', roster_id, 
    ee_prem as 'EE Prem', ee_factor as 'EE Factor', ee_carr_fee as 'EE Carr Fee', es_prem as 'ES Prem', es_factor as 'ES Factor', es_carr_fee as 'ES Carr Fee', ec_prem as 'EC Prem', ec_factor as 'EC Factor', ec_carr_fee as 'EC Carr Fee', 
    ef_prem as 'EF Prem', ef_factor as 'EF Factor', ef_carr_fee as 'EF Carr Fee', 
    ((ee_prem * ee_census) + (ec_prem * ec_census) + (es_prem * es_census) + (ef_prem * ef_census)) as 'Total Premium Billed Per Plan',
    CAPM as 'CAPM', SMR as 'SMR', HCAR as 'HCAR', GA as 'GA', WA as 'WA', 
    ADMN as 'ADMN', BADM as 'BADM', HCRD as 'HCRD', MKTF as 'MKTF', NETF as 'NETF', OTHR as 'OTHR', RPRF as 'RPRF', SMRF as 'SMRF', 
    TECH as 'TECH', LGTT as 'LGTT', RPTT as 'RPTT', total as 'Total Non Recievable Admin Fees'
from cte1
WHERE 
    -- treaty_id in (31,32) and quote_selected = 1 and person_is_active = 1 and opportunity_name in (@opportunity_name) and surplus_option in (@surplus_option) and tpa_name in (@tpa_name) and ediybs_status in (@status_name) and renewal_y_or_n in (@renewal_y_or_n) and quote_effective_date  in (@quote_effective_date )
	treaty_id in (31,32) and quote_selected = 1 and person_is_active = 1  and opportunity_name LIKE '%71 Construction (R) 2023%' and surplus_option = 0
order by plan_id;
















