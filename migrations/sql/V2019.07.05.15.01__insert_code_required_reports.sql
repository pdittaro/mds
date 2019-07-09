
INSERT INTO public.mine_report_category
(mine_report_category, description, display_order, active_ind, create_user, create_timestamp, update_user, update_timestamp)
VALUES 
	('H&S', 'Health and Safety', 10, true, 'system-mds', now(), 'system-mds', now()),
	('GSE', 'GeoScience and Environmental', 20, true, 'system-mds', now(), 'system-mds', now()),
	('GTC', 'Geotechnical', 30, true, 'system-mds', now(), 'system-mds', now()),
	('OTH', 'Other', 40, true, 'system-mds', now(), 'system-mds', now())
on conflict do nothing;

INSERT INTO public.mine_report_due_date_type
(mine_report_due_date_type, description, active_ind, create_user, create_timestamp, update_user, update_timestamp)
VALUES
	('REG', 'Regular Intervals', true, 'system-mds', now(), 'system-mds', now()),
	('REQ', 'Available on Request', true, 'system-mds', now(), 'system-mds', now()),
	('PMT', 'Permit Requirement', true, 'system-mds', now(), 'system-mds', now()),
	('EVT', 'An Event Occured', true, 'system-mds', now(), 'system-mds', now())
on conflict do nothing;


ALTER TABLE public.mine_report_definition ALTER COLUMN due_date_period_months DROP NOT NULL;
ALTER TABLE public.mine_report_definition ALTER COLUMN mine_report_definition_guid set DEFAULT gen_random_uuid();
ALTER TABLE public.mine_report_definition ALTER COLUMN report_name TYPE character varying(100);

DROP TABLE IF EXISTS tmp_report_definition_compliance;
CREATE TEMPORARY TABLE tmp_report_definition_compliance(
	tmp_id serial primary key, 
	mrd_id integer, 
	report_name character varying(100),
	due_date_type character varying(3),
	due_date_period integer,
	compliance_act character varying(5), 
	compliance_section character varying(2),
	compliance_sub_section character varying(2),
	compliance_paragraph character varying(2),
	compliance_article_id integer
);
INSERT INTO tmp_report_definition_compliance
(report_name, due_date_type, due_date_period, compliance_act, compliance_section, compliance_sub_section, compliance_paragraph)
VALUES 
	('OHSC Annual Report','REG',12, 'HSRCM','1','9','3'),
	('Right to Refuse Report','EVT',null, 'HSRCM','1','10','7'),
	('Report of MERP Test','REG',12, 'HSRCM','3','7','1'),
	('Underground Fueling Station Report','PMT',null, 'HSRCM','4','3','3'),
	('Underground Oil and Grease Storage Area Report','PMT',null, 'HSRCM','4','3','4'),
	('Flammable Gas Report','EVT',null, 'HSRCM','6','42','3'),
	('Free Fall Tests Report','EVT',null, 'HSRCM','7','5','13'),
	('Defective Explosives Report','EVT',null, 'HSRCM','8','3','4'),
	('Careless Acts Report','EVT',null, 'HSRCM','8','3','9'),
	('Drilling Precaution Procedures Report','PMT',null, 'HSRCM','8','7','2'),
	('Annual Summary of Exploration Activities','REG',12, 'HSRCM','9','2','1'),
	('Management Plan for Riparian Area','PMT',null,'HSRCM','9','5','1'),
	('Terrain Stability Remediation Plan','EVT',null,'HSRCM','9','7','1'),
	('Terrain Incident Report','EVT',null, 'HSRCM','9','7','1'),
	('ARD Surface Material Request','PMT',null, 'HSRCM','9','10','1'),
	('Cessation of Exploration Reclamation Report','EVT',null, 'HSRCM','9','13','1'),
	('Permit Application: ML/ARD Management Plan','REG',null, 'HSRCM','10','1','3'),
	('Duty to Report Safety Issue at TSF','EVT',null, 'HSRCM','10','1','6'),
	('Breach and Inundation Study/Failure Runout Assessment','REQ',null, 'HSRCM','10','1','11'),
	('ML/ARD Management Plan','REG',null, 'HSRCM','10','1','16'),
	('Departure from Approval for Reclamation Program or Mine Plan','PMT',null, 'HSRCM','10','1','18'),
	('5-year Mine Plan','REG',60, 'HSRCM','10','4','1'),
	('ITRB Terms of Reference','PMT',null, 'HSRCM','10','4','2'),
	('TSF Emergency Preparedness and Response Plan','PMT',null, 'HSRCM','10','4','2'),
	('Annual Reclamation Report','REG',12, 'HSRCM','10','4','4'),
	('Annual DSI','REG',12, 'HSRCM','10','4','4'),
	('ITRB Activities Report','REG',12, 'HSRCM','10','4','4'),
	('Summary of TSF or Dam Safety Recommendations','REG',12, 'HSRCM','10','4','4'),
	('Performance of High Risk Dumps','REG',12, 'HSRCM','10','4','4'),
	('Mine Plan Update','REG',60, 'HSRCM','10','4','5'),
	('Dam Safety Review','REG',60, 'HSRCM','10','4','5'),
	('As-built Reports','REG',60, 'HSRCM','10','4','5'),
	('TSF, WSF or Dam As-built Report','REG',null, 'HSRCM','10','5','1'),
	('OMS Manual','PMT',null, 'HSRCM','10','5','2'),
	('Materials Inventory Report','EVT',null, 'HSRCM','10','5','7'),
	('Closure Drawings and Plans','REG',null, 'HSRCM','10','6','3'),
	('Closure of TSF or Dam Report','PMT',null, 'HSRCM','10','6','7'),
	('TSF Closure OMS','PMT',null, 'HSRCM','10','6','8'),
	('Closure Management Manual','REG',null, 'HSRCM','10','6','9'),
	('Appeal to CIM Report','EVT',null, 'MA','33','1',null),
	('Workplace Monitoring Program','REQ',null, 'HSRCM','2','1','3'),
	('Report of Emergency Warning System Test','REQ',null, 'HSRCM','3','13','4'),
	('Maintenance Record','REQ',null, 'HSRCM','4','4','15'),
	('Water Management Plan','PMT',null, 'HSRCM','10','1','3'),
	('Annual Reconciliation of Water Balance and Water Management Plans','REQ',null, 'HSRCM','10','4','1'),
	('Tailings Management System','REQ',null, 'HSRCM','10','4','2'),
	('TSF Risk Assessment','REQ',null, 'HSRCM','10','4','2'),
	('TSF and Dam Registry','REQ',null, 'HSRCM','10','4','3'),
	('TSF and Dam Registry Updates','REQ',null, 'HSRCM','10','4','4'),
	('Term Extension','EVT',null, 'MA','10','6',null),
	('Acquisition of a Mine','EVT',null, 'MA','11','1',null),
	('Engineering Report','EVT',null, 'MA','18',null,null),
	('ITRB Qualifications','PMT',null, 'HSRCM','10','4','2'),
	('Health and Safety Program','REQ',null, 'HSRCM','1','6','9'),
	('Dump OMS Manual','REQ',null, 'HSRCM','10','5','2'),
	('Standard Operating Procedures or Safe Work Procedures','REQ',null, 'HSRCM','3','4','2'),
	('Mine Emergency Response Plan','REG',null, 'HSRCM','3','7','1')
ON CONFLICT DO NOTHING;

INSERT INTO public.mine_report_definition
(report_name, description, due_date_period_months, mine_report_due_date_type, active_ind, create_user, create_timestamp, update_user, update_timestamp)
select report_name, '', due_date_period, due_date_type, 'true', 'system-mds', now(), 'system-mds', now() from tmp_report_definition_compliance;
