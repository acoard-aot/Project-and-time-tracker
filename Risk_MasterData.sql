INSERT INTO public.risk_questions (id,question,category,"riskLevel","questionNo") VALUES 
('7867249a-657a-489a-9203-1754ed8885cc','How many separate contracts are estimated for this project?',1,NULL,2)
,('1cfc4878-0257-4da8-8838-1729be5b8ee1','From project defintion to project close-out, what is the expected duration of the project?',2,NULL,4)
,('1f71e8bc-5b88-40c3-ab99-553368ebf685','How many Ministries or BPS Entities are directly involved in the project?',2,NULL,5)
,('2d4fd180-ef23-4134-8014-be2ec8ed1ec5','Is their high public interest in the project?',4,NULL,3)
,('e11046b5-dfcf-4343-aff8-651670cc783f','Does this project have a documented project plan with clearly identified Roles & Responsibilities?',3,NULL,2)
,('a08e56db-b334-4270-affc-a8f6e2c0fd0a','What level of priority is the project to the owning Ministry?',3,NULL,3)
,('ec300240-d516-40d4-b9b3-8a23d8f4e951','Will the resulting contract offer government opportunity for innovation or modernization',2,NULL,7)
,('cf3e8c59-eefb-48cb-b427-4f1abdae2ed1','Does the organization anticipate a shortage of available personnel with appropriate skills during a significant period of the project?',3,NULL,4)
,('6b8217b2-36e9-4e7b-80ee-4c60ced529af','Consider the following criteria regarding knowledge and experience:
<ul>
<li>The project will use a proven approach</li>
<li>This type of project has been done before in the BC Gov</li>
<li>The project will use resources that have been applied to this type of project before</li>
</ul>',2,NULL,8)
,('94ec86da-f955-4e3d-b0ba-932b3044abdb','Are the services public facing?',2,NULL,9)
;
INSERT INTO public.risk_questions (id,question,category,"riskLevel","questionNo") VALUES 
('e969a6eb-2819-445f-a3f5-1aad40ad75b4','What is the estimated Total Contract Value of this procurement?',1,NULL,1)
,('4170bc6a-3146-486a-89fe-d147718678cc','Will the project result in a contract that is one of a larger bundle of contracts supporting a strategic initiative? (i.e. requires an integrator)',2,NULL,1)
,('183b80f2-4688-41fd-ae1c-5a6e7f777c3f','Is the project susceptible to time delays? Time delays can have a number of causes, such as the following:
<ul>
<li>Crosses Election periods</li>
<li>Key timelines happen around End of Fiscal</li>
<li>Complex Governance Requirements</li>
<li>Known Capacity Issues</li>
<li>Timelines are compressed or unattainable</li>
<li>Involves emerging technologies</li>
</ul>',1,NULL,3)
,('3c998138-1cd7-4ae4-b86f-5b18c404b2c8','What is the anticipated procurement approach?',2,NULL,2)
,('b1298897-3bb9-4ccf-9a3c-fb0a72eb0dec','Are there unique complex variables within this project? Such as:
<ul>
<li>The services currently reside outside of government with a vendor</li>
<li>There may require a transition from one vendor another</li>
<li>There are a small number of individual requirements to define</li>
<li>There is a potential labour impact to the procurement</li>
<li>Other high impact unique feature not listed</li>
</ul>',2,NULL,3)
,('c81159f4-42bb-48b1-8338-592df3b43eff','What is the supplier capability and willingness?',2,NULL,6)
,('f69586ae-dd89-44dc-8288-e4efe98984c2','How many total people (part-time or full-time on the project, including BC Gov employees and individual contractors) are required to complete this project at its peak activity?',3,NULL,1)
,('dfd744a6-c142-42e9-9dc9-377407f8bceb','Has the assigned lead from the project team worked on a project of this size and complexity before?',3,NULL,5)
,('82d17998-d5a7-4a15-830d-8a39d2e68a01','Are there unique challenges to ensure that this project complies with relevant Treasury Board policy requirements, such as those regarding security, GBA+, privacy, and management of government information?',4,NULL,1)
,('a19f05bd-8172-4994-b991-fc717b0e46f2','Are there any unique socio-economic considerations that must be taken into account?',4,NULL,2)
;


INSERT INTO public.risk_answers (id,answer,score,"questionId") VALUES 
('d521e811-4c1d-47ee-ad11-d0fc0f8081b2','One of the statements is true',2,'b1298897-3bb9-4ccf-9a3c-fb0a72eb0dec')
,('2ff04dac-462b-46c6-8775-6661edc100c9','1',1,'f69586ae-dd89-44dc-8288-e4efe98984c2')
,('d394fa47-e01b-4236-8310-d0287b11bd77','2-5',2,'f69586ae-dd89-44dc-8288-e4efe98984c2')
,('6adb707a-8e3a-4cc0-a8f6-e22de849cdf7','6-11',3,'f69586ae-dd89-44dc-8288-e4efe98984c2')
,('387f42ca-021a-4c92-8b25-230c3bfab4b1','12-20',4,'f69586ae-dd89-44dc-8288-e4efe98984c2')
,('739b3ec9-b022-455d-bfa8-f3a4da4b5427','20',5,'f69586ae-dd89-44dc-8288-e4efe98984c2')
,('1836784b-ed08-44b7-a898-8cf3f5119fe4','Potentially',2,'a19f05bd-8172-4994-b991-fc717b0e46f2')
,('4ddd151e-751c-43e3-9f07-794b1003de70','Potentially',2,'2d4fd180-ef23-4134-8014-be2ec8ed1ec5')
,('cd589aa2-f653-4121-abb0-746c54b42a1b','The project is a critical priority: all resources necessary will be allocated to it',1,'a08e56db-b334-4270-affc-a8f6e2c0fd0a')
,('9c5029ec-f3c0-4a28-be70-433f1a1122cb','No opportunity for innovation',1,'ec300240-d516-40d4-b9b3-8a23d8f4e951')
;
INSERT INTO public.risk_answers (id,answer,score,"questionId") VALUES 
('5641fe2c-a6d2-4434-9d0b-15a1c99bbb22','Potential opportunity',2,'ec300240-d516-40d4-b9b3-8a23d8f4e951')
,('6c175262-5a0e-4120-b1ac-1fd3d65943ba','Some opportunity',3,'ec300240-d516-40d4-b9b3-8a23d8f4e951')
,('e047e857-e7d8-468e-8380-d2990f3bc384','Definite opportunity for innovation',4,'ec300240-d516-40d4-b9b3-8a23d8f4e951')
,('513e8c32-0375-4d5d-9821-505fa3285b6a','No',1,'cf3e8c59-eefb-48cb-b427-4f1abdae2ed1')
,('e0130c24-c029-411f-873e-e27454e8c98e','Yes',3,'cf3e8c59-eefb-48cb-b427-4f1abdae2ed1')
,('72bd11ac-7391-4ed0-a8f9-40cf590024fb','All three criteria are met',1,'6b8217b2-36e9-4e7b-80ee-4c60ced529af')
,('10860622-30e2-410e-b5a4-9047cbae0345','Two of the three criteria are met',2,'6b8217b2-36e9-4e7b-80ee-4c60ced529af')
,('ac57c6e2-03ee-4778-a9c6-813a7258bb0f','One of the three criteria is met',3,'6b8217b2-36e9-4e7b-80ee-4c60ced529af')
,('3c83c9f0-01bc-4ad4-901a-904503f0a88d','None of the three criteria are met',4,'6b8217b2-36e9-4e7b-80ee-4c60ced529af')
,('a73c8361-9885-43d8-b5c7-c20c3e60a84d','Yes',1,'dfd744a6-c142-42e9-9dc9-377407f8bceb')
;
INSERT INTO public.risk_answers (id,answer,score,"questionId") VALUES 
('0e24afcf-a141-474b-9e67-9c36e1119eed','No',3,'dfd744a6-c142-42e9-9dc9-377407f8bceb')
,('464f4657-85c0-47b3-8a09-4097d0df174f','No',1,'94ec86da-f955-4e3d-b0ba-932b3044abdb')
,('df250e69-b749-46b8-9aaa-97fca80ce0b0','Limited',2,'94ec86da-f955-4e3d-b0ba-932b3044abdb')
,('0c8e249f-bc3a-4b7c-ab30-bebc1b95d0d0','Some',3,'94ec86da-f955-4e3d-b0ba-932b3044abdb')
,('576e0081-9202-47c0-b888-686dd29f820a','Yes',4,'94ec86da-f955-4e3d-b0ba-932b3044abdb')
,('81cb9cd9-1a52-489d-ae61-9b8336257561','The project fully complies with all applicable policies. Alternatively, the project is not subject to any of these policies',1,'82d17998-d5a7-4a15-830d-8a39d2e68a01')
,('983db460-0a08-4b5c-9dc3-b9aee91ba4ef','There are some challenges associated with policy requirements, but the project team is adequately equipped to address these',2,'82d17998-d5a7-4a15-830d-8a39d2e68a01')
,('49b011a2-9571-4c52-aa86-767af4079b07','There are some challenges associated with policy requirements and there is a lack of confidence that policy requirements can be met on schedule and within the budget',3,'82d17998-d5a7-4a15-830d-8a39d2e68a01')
,('03f1bbdf-4e3f-40eb-8fee-154a1dc8fb49','No',1,'4170bc6a-3146-486a-89fe-d147718678cc')
,('74afbd0f-d782-4e00-b56c-6c0a00bc8b91','Yes',3,'4170bc6a-3146-486a-89fe-d147718678cc')
;
INSERT INTO public.risk_answers (id,answer,score,"questionId") VALUES 
('af07c63d-4c96-40ad-83e5-a9e06ab64fb6','over $10 million',10,'e969a6eb-2819-445f-a3f5-1aad40ad75b4')
,('aa70f71d-7952-4d1e-8e80-612e64aaa226','Under 1 month',1,'1cfc4878-0257-4da8-8838-1729be5b8ee1')
,('78500ca2-c957-4999-96a2-360e5ec78f45','>50k',2,'e969a6eb-2819-445f-a3f5-1aad40ad75b4')
,('41a02614-dae7-4c48-b1d6-b4c241e2d62f','>250k',4,'e969a6eb-2819-445f-a3f5-1aad40ad75b4')
,('f24e1de4-824b-4eec-aac0-5dade4d3c2b9','500k-1 million',6,'e969a6eb-2819-445f-a3f5-1aad40ad75b4')
,('23a93640-3a41-44b9-9f9a-71ee45f7bffb','$1-10 million',8,'e969a6eb-2819-445f-a3f5-1aad40ad75b4')
,('a76fe051-d46b-4ca5-9029-a2114b3fc3b2','No, the project is not susceptible',2,'183b80f2-4688-41fd-ae1c-5a6e7f777c3f')
,('a5fdcb8e-3464-4eff-961b-329f0b1858a9',' Yes, the project is moderately susceptible; time delays will have minor effects on the schedule',6,'183b80f2-4688-41fd-ae1c-5a6e7f777c3f')
,('ce0d7769-846c-4f1d-8f56-a3c1099af29f','Yes, the project is highly susceptible; time delays will have major effects on the schedule',10,'183b80f2-4688-41fd-ae1c-5a6e7f777c3f')
,('cf38beb1-58af-43c3-be69-0706a0806df8','Five or more',10,'7867249a-657a-489a-9203-1754ed8885cc')
;
INSERT INTO public.risk_answers (id,answer,score,"questionId") VALUES 
('2cc39349-373b-4aa6-9046-9bd23fa24610','One',2,'7867249a-657a-489a-9203-1754ed8885cc')
,('e6379225-7cd4-48e9-9d3b-7fee086dd006','Two',4,'7867249a-657a-489a-9203-1754ed8885cc')
,('88ea130f-75dd-4dc1-a12d-4f0d6c4e81e5','Three',6,'7867249a-657a-489a-9203-1754ed8885cc')
,('07b9cbd0-719b-4f07-8713-ff220267239c','Four',8,'7867249a-657a-489a-9203-1754ed8885cc')
,('dfe7f1a2-50f0-4a7f-bd18-480640d9dc77','Directed (sole-source,NOI)',2,'3c998138-1cd7-4ae4-b86f-5b18c404b2c8')
,('704c3d76-bd96-41f9-ad16-6bf44850a07e','A public tender (request for quotation, invitation to tender, request for proposal)',6,'3c998138-1cd7-4ae4-b86f-5b18c404b2c8')
,('0ed50575-9485-427d-888d-0fd82b1f86d8','Two of the statements are true',4,'b1298897-3bb9-4ccf-9a3c-fb0a72eb0dec')
,('8613bd45-480f-4248-8b9d-9a42a5676b21','Three of the statements are true',6,'b1298897-3bb9-4ccf-9a3c-fb0a72eb0dec')
,('13c84ee9-84f3-4b6a-907e-121e1ea2c601','Complex process (NRFP, JSRFP, etc...)',10,'3c998138-1cd7-4ae4-b86f-5b18c404b2c8')
,('3adcf83e-9c1f-47e9-b891-e80ed80fb69a','A standing offer call-up or Supply Arrangement',4,'3c998138-1cd7-4ae4-b86f-5b18c404b2c8')
;
INSERT INTO public.risk_answers (id,answer,score,"questionId") VALUES 
('1410476e-9e85-46ac-9336-7162365049bd','Use of new procurement tools (but have been approved by LSB/PSB)',8,'3c998138-1cd7-4ae4-b86f-5b18c404b2c8')
,('515f667d-d18a-4250-82e9-35e84e84c3df','None of the statements are true',0,'b1298897-3bb9-4ccf-9a3c-fb0a72eb0dec')
,('d2ef16c3-1253-430b-8f04-3d1939c8b269','Four of the statements are true',8,'b1298897-3bb9-4ccf-9a3c-fb0a72eb0dec')
,('ed789931-357e-4e83-ae9b-42c2f6cb47fd','All Five of the statements are true',10,'b1298897-3bb9-4ccf-9a3c-fb0a72eb0dec')
,('e33e4efa-b19a-4ca9-9629-6e08f39d9885','over 24 months',5,'1cfc4878-0257-4da8-8838-1729be5b8ee1')
,('a1bb9194-b4be-4b61-a67d-1be349e1677f','12-24 Months',4,'1cfc4878-0257-4da8-8838-1729be5b8ee1')
,('d5116ead-4df2-456f-92f5-7df6091703fc','The project involves only one Ministry or Entity',1,'1f71e8bc-5b88-40c3-ab99-553368ebf685')
,('0d4aeab8-7bd6-48b0-a6a9-b522ace7f924','The project involves two other Ministries or Entities',2,'1f71e8bc-5b88-40c3-ab99-553368ebf685')
,('87dfe9b9-afa0-426e-861f-e8c90d7689a5','2-6 Months',2,'1cfc4878-0257-4da8-8838-1729be5b8ee1')
,('c2312008-de5c-4878-9ba4-203807052d8f','7-12 Months',3,'1cfc4878-0257-4da8-8838-1729be5b8ee1')
;
INSERT INTO public.risk_answers (id,answer,score,"questionId") VALUES 
('0eeae774-9273-4fa1-bcf4-a0072bf69821','The project involves three other Ministries or Entities',3,'1f71e8bc-5b88-40c3-ab99-553368ebf685')
,('7e5e6063-6e37-415e-9367-b2f9ab1c7f5f','The project involves at least four other Ministries or Entities',4,'1f71e8bc-5b88-40c3-ab99-553368ebf685')
,('087c00f6-9541-413b-b300-a8f3f6e5bd69','There are qualified suppliers in the market willing to work with the BC Gov and are capable of providing these services',1,'c81159f4-42bb-48b1-8338-592df3b43eff')
,('19dc1942-b79f-447b-9004-29f0a299ac6a','There is a limited number of qualified suppliers in the market or some suppliers are reluctant to work with the BC Gov',3,'c81159f4-42bb-48b1-8338-592df3b43eff')
,('c450b926-b949-48d3-bf67-1e5ef2936faa',' Yes or Not Required',1,'e11046b5-dfcf-4343-aff8-651670cc783f')
,('f6319753-11fe-4e28-8ed4-6195a6b9bbb7','It is estimated that only one supplier or there are no qualified suppliers that can meet the requirements',5,'c81159f4-42bb-48b1-8338-592df3b43eff')
,('c94f6e3a-f9d0-4347-9786-46c439664e99','Partially',2,'e11046b5-dfcf-4343-aff8-651670cc783f')
,('efe7a811-e2b2-4136-ac76-ad5754236d5c','No',3,'e11046b5-dfcf-4343-aff8-651670cc783f')
,('cb3d0fec-11c3-467e-a688-0307910225f7','Yes',3,'2d4fd180-ef23-4134-8014-be2ec8ed1ec5')
,('917b957a-4614-4421-bb32-25f317028005','The project is a normal priority: resources may be shared with a project of equal or higher priority',3,'a08e56db-b334-4270-affc-a8f6e2c0fd0a')
;
INSERT INTO public.risk_answers (id,answer,score,"questionId") VALUES 
('7748816d-ab15-448d-a4b7-a14476d247d1','The project is a not a priority: resources may be diverted to a project of equal or higher priority',5,'a08e56db-b334-4270-affc-a8f6e2c0fd0a')
,('2d8b22af-1b06-4728-830a-2fb0726b85ca','No',1,'2d4fd180-ef23-4134-8014-be2ec8ed1ec5')
,('f45d442e-ab56-4067-ab93-86ee3fa0d595','Yes',3,'a19f05bd-8172-4994-b991-fc717b0e46f2')
,('848bd7de-d59d-4175-8851-04c5c104ab9a','No',1,'a19f05bd-8172-4994-b991-fc717b0e46f2')
;