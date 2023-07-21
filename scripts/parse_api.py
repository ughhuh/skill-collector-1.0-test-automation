import requests
import pandas as pd

r = requests.get('https://api.skill.wimmalab.org/skills?softskills=true')
skills = r.json()

hard_skills_1 = []
soft_skills_1 = []

hard_skills_2 = []
soft_skills_2 = []

hard_skills_3 = []
soft_skills_3 = []

hard_skills_4 = []

hard_skills_btn = []
soft_skills_btn = []

hard_skills_id = []
soft_skills_id = []

hard_skills_name = []
soft_skills_name = []

hard_skills_desc = []
soft_skills_desc = []

for i in skills:
    if i["category"] == "Soft skills": 
        soft_skills_1.append(i["id"] + "-1")
        soft_skills_2.append(i["id"] + "-2")
        soft_skills_3.append(i["id"] + "-3")
        soft_skills_btn.append(i["id"] + "-btn")

        soft_skills_id.append(i["id"])
        soft_skills_name.append(i["title"])
        soft_skills_desc.append(i["gen_description"])
    else: 
        hard_skills_1.append(i["id"] + "-1")
        hard_skills_2.append(i["id"] + "-2")
        hard_skills_3.append(i["id"] + "-3")
        hard_skills_4.append(i["id"] + "-4")
        hard_skills_btn.append(i["id"] + "-btn")

        hard_skills_id.append(i["id"])
        hard_skills_name.append(i["title"])
        hard_skills_desc.append(i["gen_description"])


data_1 = {
    '*** Test Cases ***': ['Cycle Hard Skills', 'Cycle Soft Skills'],
    '${setup}': ['Access Hard Skills','Access Soft Skills'],
    'e{skills_1}': [hard_skills_1, soft_skills_1],
    'e{skills_2}': [hard_skills_2, soft_skills_2],
    'e{skills_3}': [hard_skills_3, soft_skills_3],
    'e{skills_4}': [hard_skills_4, []],
    'e{skills_btn}': [hard_skills_btn, soft_skills_btn],
    '[Tags]': ['Functional,Regression,FEA21,FEA29', 'Functional,Regression,FEA21,FEA29']
}

data_2 = {
    '*** Test Cases ***': ['Hover Hard Skills', 'Hover Soft Skills'],
    '${setup}': ['Access Hard Skills','Access Soft Skills'],
    'e{skills_id}': [hard_skills_id, soft_skills_id],
    'e{skills_name}': [hard_skills_name, soft_skills_name],
    'e{skills_desc}': [hard_skills_desc, soft_skills_desc],
    '[Tags]': ['Functional,Regression,FEA21,FEA29', 'Functional,Regression,FEA21,FEA29']
}

df_1 = pd.DataFrame(data_1)
df_2 = pd.DataFrame(data_2)

df_1.to_csv('../data/cycledata.csv', index=False, sep=";", encoding='utf-8')
df_2.to_csv('../data/hoverdata.csv', index=False, sep=";", encoding='utf-8')