import requests
import pandas as pd
import random

r = requests.get('https://api.skill.wimmalab.org/skills?softskills=true')
skills = r.json()

hard_skills_id = []
soft_skills_id = []

for i in skills:
    if i["category"] == "Soft skills": 
        soft_skills_id.append(i["id"])
    else: 
        hard_skills_id.append(i["id"])

hard_skill_rand_1 = random.sample(hard_skills_id, 20)
soft_skills_rand_1 = random.sample(soft_skills_id, 3)
hard_skill_rand_1_names = []
soft_skill_rand_1_names = []

hard_skill_rand_2 = random.sample(hard_skills_id, 20)
soft_skills_rand_2 = random.sample(soft_skills_id, 3)
hard_skill_rand_2_names = []
soft_skill_rand_2_names = []

hard_skill_rand_3 = random.sample(hard_skills_id, 20)
soft_skills_rand_3 = random.sample(soft_skills_id, 3)
hard_skill_rand_3_names = []
soft_skill_rand_3_names = []

hard_skill_rand_4 = random.sample(hard_skills_id, 24)
soft_skill_rand_4 = random.sample(soft_skills_id, 6)

names_1 = [next(item["title"] for item in skills if item["id"] == i) for i in hard_skill_rand_1] + [next(item["title"] for item in skills if item["id"] == i) for i in soft_skills_rand_1]
names_2 = [next(item["title"] for item in skills if item["id"] == i) for i in hard_skill_rand_2] + [next(item["title"] for item in skills if item["id"] == i) for i in soft_skills_rand_2]
names_3 = [next(item["title"] for item in skills if item["id"] == i) for i in hard_skill_rand_3] + [next(item["title"] for item in skills if item["id"] == i) for i in soft_skills_rand_3]

data_1 = {
    '*** Test Cases ***': ['E2E ENG', 'E2E FI', 'E2E SWE'],
    '${language}': ['en','fi','swe'],
    '${hash}': ['0123456789','0123456789','0123456789'],
    'e{skills_1}': [[x + "-1" for x in hard_skill_rand_1[:5]],[x + "-1" for x in hard_skill_rand_2[:5]],[x + "-1" for x in hard_skill_rand_3[:5]]],
    'e{skills_2}': [[x + "-2" for x in hard_skill_rand_1[5:10]],[x + "-2" for x in hard_skill_rand_2[5:10]],[x + "-2" for x in hard_skill_rand_3[5:10]]],
    'e{skills_3}': [[x + "-3" for x in hard_skill_rand_1[10:15]],[x + "-3" for x in hard_skill_rand_2[10:15]],[x + "-3" for x in hard_skill_rand_3[10:15]]],
    'e{skills_4}': [[x + "-4" for x in hard_skill_rand_1[15:]],[x + "-4" for x in hard_skill_rand_2[15:]],[x + "-4" for x in hard_skill_rand_3[15:]]],
    'e{skills_soft}': [[soft_skills_rand_1[x] + "-" + str(x+1) for x in range(3)],[soft_skills_rand_2[x] + "-" + str(x+1) for x in range(3)],[soft_skills_rand_3[x] + "-" + str(x+1) for x in range(3)]],
    'e{skill_titles}': [names_1,names_2,names_3],
    '${text}':['Thank you for your answer!','Kiitos vastauksestasi!','Tack för ditt svar!'],
    '[Tags]':['E2E','E2E','E2E']
}

data_2 = {
    '*** Test Cases ***': ['Skill Selection Alert'],
    '${hash}': ['0123456789'],
    'e{skills_1}': [[x + "-1" for x in hard_skill_rand_4[:6]]],
    'e{skills_2}': [[x + "-2" for x in hard_skill_rand_4[6:12]]],
    'e{skills_3}': [[x + "-3" for x in hard_skill_rand_4[12:18]]],
    'e{skills_4}': [[x + "-4" for x in hard_skill_rand_4[18:]]],
    'e{skills_soft}': [[x + "-1" for x in soft_skill_rand_4[:2]]+[x + "-2" for x in soft_skill_rand_4[2:4]]+[x + "-3" for x in soft_skill_rand_4[4:6]]],
    '[Tags]': 'Functional,Regression,FEA21,FEA29'
}

data_3 = {
    '*** Test Cases ***': ['Not Enough Hard Skills','Not Enough Soft Skills','Not Enough Both Skills'],
    '${hash}': ['0123456789','0123456789','0123456789'],
    'e{skills_1}': [[x + "-1" for x in hard_skill_rand_1[:5]],[x + "-1" for x in hard_skill_rand_2[:5]],[x + "-1" for x in hard_skill_rand_3[:4]]],
    'e{skills_2}': [[x + "-2" for x in hard_skill_rand_1[5:8]],[x + "-2" for x in hard_skill_rand_2[5:10]],[x + "-2" for x in hard_skill_rand_3[5:10]]],
    'e{skills_3}': [[x + "-3" for x in hard_skill_rand_1[10:15]],[x + "-3" for x in hard_skill_rand_2[10:15]],[x + "-3" for x in hard_skill_rand_3[10:13]]],
    'e{skills_4}': [[x + "-4" for x in hard_skill_rand_1[15:20]],[x + "-4" for x in hard_skill_rand_2[15:20]],[x + "-4" for x in hard_skill_rand_3[15:19]]],
    'e{skills_soft}': [[soft_skills_rand_1[x] + "-" + str(x+1) for x in range(3)],[soft_skills_rand_1[x] + "-" + str(x+1) for x in range(2)],[soft_skills_rand_1[x] + "-" + str(x+1) for x in range(1)]],
    '${message}': ['You have not selected enough SFIA skills. Please select 20 SFIA skills.','You have not selected enough soft skills. Please select 3 soft skills.','You have not selected enough skills. Please select 20 SFIA skills and 3 soft skills.'],
    '[Tags]':['Functional,Regression,FEA21,FEA29', 'Functional,Regression,FEA21,FEA29', 'Functional,Regression,FEA21,FEA29']
}

df_1 = pd.DataFrame(data_1)
df_2 = pd.DataFrame(data_2)
df_3 = pd.DataFrame(data_3)

df_1.to_csv('../data/e2edata.csv', index=False, sep=";", encoding='utf-8')
df_2.to_csv('../data/alertdata.csv', index=False, sep=";", encoding='utf-8')
df_3.to_csv('../data/denydata.csv', index=False, sep=";", encoding='utf-8')