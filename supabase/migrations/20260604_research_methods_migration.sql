-- Research Methods Platform Migration
-- Replaces Industrial Automation with Research Methods content
-- Contains comprehensive exam revision content from 2017-2021 papers

-- Delete old Industrial Automation data
DELETE FROM topics WHERE name LIKE '%Industrial%' OR name LIKE '%Automation%';

-- Insert Research Methods topics organized by key subject areas
INSERT INTO topics (name, course_id, order_index) VALUES
  ('Sampling Methods & Techniques', 1, 1),
  ('Research Design & Methodology', 1, 2),
  ('Data Collection Instruments', 1, 3),
  ('Qualitative & Quantitative Research', 1, 4),
  ('Ethics in Research', 1, 5),
  ('Data Analysis & Statistics', 1, 6),
  ('Report Writing & Documentation', 1, 7),
  ('Research Paradigms & Frameworks', 1, 8);

-- Get topic IDs for cards insertion
WITH topic_ids AS (
  SELECT id, name FROM topics WHERE course_id = 1 AND name LIKE '%Sampling%' OR name LIKE '%Research%' OR name LIKE '%Data%' OR name LIKE '%Qualitative%' OR name LIKE '%Ethics%' OR name LIKE '%Analysis%' OR name LIKE '%Report%' OR name LIKE '%Paradigm%'
)

-- Insert flashcards for Sampling Methods
INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'What is Probability Sampling?',
  'Probability sampling is a method where every member of the population has a known, non-zero chance of being selected. Selection is random, allowing statistical inference and estimation of sampling error. Examples: simple random, stratified random, systematic, cluster sampling.',
  'easy',
  'concept'
FROM topics WHERE name = 'Sampling Methods & Techniques' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Define Non-Probability Sampling',
  'Non-probability sampling is based on non-random criteria (e.g., convenience, judgment). Not every member has a known chance of inclusion. Results cannot be generalised with statistical confidence but are cheaper and faster. Examples: convenience sampling, quota sampling, purposive sampling.',
  'easy',
  'concept'
FROM topics WHERE name = 'Sampling Methods & Techniques' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Explain Simple Random Sampling with Example',
  'Each population element has an equal and independent chance of selection. Use random number tables or lottery method. Example: Assign numbers 1–500 to electricians; use random generator to pick 50. Every electrician has exactly 1/500 chance of selection.',
  'medium',
  'worked_example'
FROM topics WHERE name = 'Sampling Methods & Techniques' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'What is Stratified Random Sampling?',
  'Population divided into homogeneous strata (e.g., by experience level); randomly sample from each stratum, often proportionally. Example: Firm with 60% apprentices, 40% journeymen → sample 60 apprentices and 40 journeymen from respective strata.',
  'medium',
  'concept'
FROM topics WHERE name = 'Sampling Methods & Techniques' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Explain Systematic Sampling Formula and Application',
  'Select every k-th element after random start. Formula: k = Population size ÷ Sample size. Example: Population = 1000, Sample = 100 → k = 10. Random start = 7 → select 7, 17, 27, 37... Results in evenly spaced, systematic selection.',
  'medium',
  'worked_example'
FROM topics WHERE name = 'Sampling Methods & Techniques' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Distinguish Convenience vs. Purposive Sampling',
  'Convenience sampling: Select most easily available subjects (e.g., surveying students in your class). Non-deliberate, for ease only. Purposive sampling: Researcher intentionally selects based on specific characteristics (e.g., only senior engineers with 10+ years high-voltage experience). Deliberate, goal-driven.',
  'hard',
  'comparison'
FROM topics WHERE name = 'Sampling Methods & Techniques' LIMIT 1;

-- Insert flashcards for Research Design & Methodology
INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Define Research Design',
  'A research design is the overall strategy or blueprint that guides data collection, measurement, and analysis. It ensures the research question is answered validly, objectively, and economically. Provides structure, reduces bias, enables appropriate statistical analysis, and allows replication.',
  'easy',
  'concept'
FROM topics WHERE name = 'Research Design & Methodology' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Describe Laboratory Experiment Procedures',
  '1. Define variables (independent and dependent) 2. Formulate hypothesis 3. Control extraneous variables 4. Random assignment to groups 5. Manipulate independent variable 6. Measure dependent variable 7. Analyse results 8. Draw conclusions. Provides high internal validity and replicability.',
  'medium',
  'worked_example'
FROM topics WHERE name = 'Research Design & Methodology' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Distinguish Exploratory, Descriptive, and Causal Research',
  'Exploratory: loose, flexible design to explore poorly understood problems and generate hypotheses. Descriptive: structured design describing characteristics, behaviours, conditions (answers "what"). Causal: highly controlled to determine cause-effect relationships (answers "why"). Requires manipulation and comparison groups.',
  'hard',
  'comparison'
FROM topics WHERE name = 'Research Design & Methodology' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'What is a Case Study Research Design?',
  'In-depth, intensive investigation of a single case (person, organisation, event, project) in real-life context. Uses multiple data sources: interviews, documents, observations. Does not require control groups. Context-bound but can inform theory. Example: analysing single substation fire through design, maintenance, weather records, interviews.',
  'medium',
  'concept'
FROM topics WHERE name = 'Research Design & Methodology' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Explain the 9-Step Research Process',
  '1. Identify problem/question 2. Review literature 3. Formulate hypothesis/objectives 4. Design research method 5. Collect data 6. Analyse data 7. Interpret findings 8. Report/disseminate 9. Iterative loop for refinement. Process is often cyclical - unexpected results send researcher back to earlier steps.',
  'hard',
  'worked_example'
FROM topics WHERE name = 'Research Design & Methodology' LIMIT 1;

-- Insert flashcards for Data Collection Instruments
INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Define Research Instrument',
  'A research instrument is a tool used to collect, measure, and record data. Must be valid (measures what intended) and reliable (produces consistent results). Examples: questionnaire, interview guide, observation checklist, test, Likert scale, multimeter for electrical measurements.',
  'easy',
  'concept'
FROM topics WHERE name = 'Data Collection Instruments' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'What is Participant Observation?',
  'Qualitative method where researcher becomes group member being studied, participating in activities while observing and recording behaviour. Example: engineer joins maintenance team for six months, working alongside while taking research notes. Provides contextual richness but risks reactivity and observer bias.',
  'medium',
  'concept'
FROM topics WHERE name = 'Data Collection Instruments' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Describe Action Research',
  'Cyclical, participatory approach simultaneously investigating problem and taking action to solve it. Involves: planning, acting, observing, reflecting. Often occurs within an organisation. Example: lecturer implements new teaching method, measures performance, adjusts method, repeats cycle. Integrates research with intervention.',
  'medium',
  'concept'
FROM topics WHERE name = 'Data Collection Instruments' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Explain Questionnaire as Research Instrument',
  'Series of written questions (open-ended or closed-ended) completed by respondents. Can be self-administered (postal, online) or interviewer-administered. Advantages: wide coverage, low cost. Disadvantages: low response rate, no clarification. Example: 15-question printed form about workplace electrical safety distributed to 200 electricians.',
  'medium',
  'concept'
FROM topics WHERE name = 'Data Collection Instruments' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Compare Personal Interview vs. Postal Questionnaire',
  'Interview (6 marks): High response, clarification possible, visual aids usable, deep responses, interviewer bias. Expensive, time-consuming, privacy concerns. Postal (8 marks): Low cost, no bias, anonymous, wide coverage, low response rate, no clarification, slow, assumes literacy.',
  'hard',
  'comparison'
FROM topics WHERE name = 'Data Collection Instruments' LIMIT 1;

-- Insert flashcards for Qualitative & Quantitative Research
INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Define Qualitative Research',
  'Exploratory approach seeking to understand human behaviour, experiences, and social phenomena from those involved. Collects non-numerical data (words, images, observations); uses interpretive analysis. Methods: interviews, focus groups, case studies, ethnography. Generates rich, contextual understanding rather than testing hypotheses.',
  'easy',
  'concept'
FROM topics WHERE name = 'Qualitative & Quantitative Research' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'List Strengths and Weaknesses of Qualitative Research',
  'Strengths: Deep contextual understanding, flexible design, captures perspectives, explores new topics, generates hypotheses. Weaknesses: Not easily generalised, time-consuming, researcher bias, difficult replication, subjective analysis. Uses small purposive samples (10-30) vs. large random samples for quantitative.',
  'hard',
  'comparison'
FROM topics WHERE name = 'Qualitative & Quantitative Research' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Distinguish Quantitative Research from Qualitative',
  'Quantitative: Numerical data, measures/compares, large probability samples, surveys/experiments, statistical analysis, generalisable. Qualitative: Non-numerical, explores meanings, small purposive samples, interviews/observations, thematic analysis, contextual/not generalisable. Quantitative = breadth, Qualitative = depth.',
  'hard',
  'comparison'
FROM topics WHERE name = 'Qualitative & Quantitative Research' LIMIT 1;

-- Insert flashcards for Ethics in Research
INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'What is Ethics in Research and Why Important?',
  'Ethics refers to moral principles and professional standards guiding honest, responsible research with respect for participants. Importance: protects from harm, maintains trust, ensures integrity, complies with law, prevents fabrication/plagiarism. Four key principles: informed consent, anonymity, right to service, voluntary participation.',
  'easy',
  'concept'
FROM topics WHERE name = 'Ethics in Research' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Explain Informed Consent with Example',
  'Participants receive full information (purpose, procedures, risks, benefits, right to withdraw) and voluntarily agree, usually with signed form. Example: Before measuring electricians'' reaction times, explain test purpose, potential discomfort, right to stop anytime, then obtain signed consent. Must be documented and voluntary.',
  'easy',
  'concept'
FROM topics WHERE name = 'Ethics in Research' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Define Anonymity and Confidentiality',
  'Anonymity: Researcher cannot identify which participant provided data; no personal identifiers collected. Confidentiality: Researcher knows identities but agrees not to disclose to others; data stored securely. Anonymity stronger than confidentiality. Example: Anonymous survey vs. named survey with secure coding.',
  'medium',
  'concept'
FROM topics WHERE name = 'Ethics in Research' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'What is a Pilot Study?',
  'Small-scale preliminary test of research design, instruments, procedures before main study. Identifies problems with wording, timing, technical issues. Clarifies logistics. Example: Testing questionnaire on 10 electricians before distribution to 200; revise unclear questions based on pilot feedback.',
  'easy',
  'concept'
FROM topics WHERE name = 'Ethics in Research' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Describe Research Ethics Cost/Benefit Analysis',
  'Ethical assessment comparing potential harms (costs) to participants, society, environment against potential benefits (knowledge, improved practices, societal gain). Research justified only if benefits substantially outweigh costs. Unavoidable harm must be minimised. Example: Safety study with minor discomfort justified by major accident prevention benefits.',
  'hard',
  'worked_example'
FROM topics WHERE name = 'Ethics in Research' LIMIT 1;

-- Insert flashcards for Data Analysis & Statistics
INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'What is the Role of Statistics in Research?',
  'Design: sample size, randomisation. Summarisation: mean, median, std dev. Inference: generalise sample to population via confidence intervals, hypothesis tests. Relationships: correlation, regression. Reliability/validity testing: Cronbach''s alpha, standard error. Prediction: time series, forecasting, ML models.',
  'hard',
  'concept'
FROM topics WHERE name = 'Data Analysis & Statistics' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Define Measures of Central Tendency',
  'Single values summarising dataset center: Mean (arithmetic average: Σx/n), Median (middle value when ordered), Mode (most frequent). Example: dataset 3,5,5,7,10 has mean=6, median=5, mode=5. Sensitive to outliers (mean) vs. robust (median).',
  'easy',
  'concept'
FROM topics WHERE name = 'Data Analysis & Statistics' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Explain Measures of Dispersion',
  'Describe data spread: Range (max-min), Variance (avg squared deviation from mean: Σ(x-x̄)²/n), Standard Deviation (√variance, same units as data), IQR (Q3-Q1, middle 50%). Example: dataset with larger std dev more variable. Use for assessing consistency, risk, quality control.',
  'medium',
  'concept'
FROM topics WHERE name = 'Data Analysis & Statistics' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Explain Grouped Data Mean Calculation',
  'Formula: x̄ = Σ(f·xₘ)/Σf where f=frequency, xₘ=class midpoint. Example: 11 shops selling 4-12 computers, 14 shops selling 13-21, etc. Midpoints: 8, 17, 26, 35, 44. Calculate f·xₘ for each, sum to 1120, divide by Σf=50 → mean=22.4 computers per shop.',
  'hard',
  'worked_example'
FROM topics WHERE name = 'Data Analysis & Statistics' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'What is Pearson Correlation Coefficient?',
  'Measures linear relationship between two continuous variables. Formula: r = Σ(x-x̄)(y-ȳ) / √[Σ(x-x̄)²·Σ(y-ȳ)²]. Range: -1 (perfect negative) to +1 (perfect positive); 0=no correlation. Example: r=0.85 indicates strong positive relationship between voltage and motor speed.',
  'hard',
  'concept'
FROM topics WHERE name = 'Data Analysis & Statistics' LIMIT 1;

-- Insert flashcards for Report Writing & Documentation
INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'What are Chapters in a Research Report?',
  'Ch1: Introduction (background, problem, questions). Ch2: Literature Review (existing research, gaps). Ch3: Methodology (design, sample, instruments, procedures, ethics). Ch4: Results (tables, figures, raw output). Ch5: Discussion (interpretation, comparison). Ch6: Conclusions & Recommendations. References & Appendices. Professional academic format with headers, footers, table of contents.',
  'easy',
  'concept'
FROM topics WHERE name = 'Report Writing & Documentation' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Explain the Terms Abstract, Journal, Bibliography, References',
  'Abstract: 150-300 word summary of problem, methods, key results, conclusions. Journal: peer-reviewed periodical publishing research (e.g., IEEE Transactions). Bibliography: ALL sources consulted. References: ONLY sources explicitly cited. Abstract allows quick relevance assessment; journals provide validated sources; bibliography shows breadth; references enable verification.',
  'medium',
  'concept'
FROM topics WHERE name = 'Report Writing & Documentation' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Why is Report Writing Significant?',
  'Communicates findings to stakeholders and public. Provides permanent archive. Helps decision-making. Demonstrates accountability. Advances careers via publications. Enables replication. Fulfills academic requirements. Without written report, research is incomplete and inaccessible to others.',
  'easy',
  'concept'
FROM topics WHERE name = 'Report Writing & Documentation' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Guidelines for Harvard Referencing (Books)',
  'Two authors: Floyd, T.L. and Buchla, D.M. (2020) Electronics Fundamentals: Circuits, Devices and Applications. 9th edn. Pearson. Three authors: Rashid, M.H., Muhammad, H. and Hasan, R. (2018) Power Electronics... 4th edn. Pearson. In-text: (Floyd and Buchla, 2020) or (Rashid et al., 2018). Always include: authors, year, title, edition, publisher.',
  'medium',
  'worked_example'
FROM topics WHERE name = 'Report Writing & Documentation' LIMIT 1;

-- Insert flashcards for Research Paradigms & Frameworks
INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'What is a Research Paradigm?',
  'Fundamental worldview guiding research. Encompasses: Ontology (nature of reality), Epistemology (nature of knowledge), Methodology (appropriate methods). Influences what questions asked, how data collected, how findings interpreted. Two major: Positivism and Interpretivism.',
  'easy',
  'concept'
FROM topics WHERE name = 'Research Paradigms & Frameworks' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Describe Positivism Research Paradigm',
  'Ontology: Objective reality exists independently. Epistemology: Knowledge from observable, measurable facts; value-free. Methodology: Quantitative, experiments, surveys, statistics; aims for general laws. Researcher: Detached, neutral. Example: Testing voltage effect on motor speed via controlled experiment with measurements, regression analysis.',
  'medium',
  'concept'
FROM topics WHERE name = 'Research Paradigms & Frameworks' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Describe Interpretivism (Constructivism) Paradigm',
  'Ontology: Multiple, subjective, socially constructed realities. Epistemology: Knowledge built through meanings, interpretations, context; co-constructed. Methodology: Qualitative, interviews, case studies, ethnography; aims for deep understanding. Researcher: Involved, reflexive, interpretive. Example: Exploring how technicians perceive live-line risks via interviews, thematic analysis.',
  'medium',
  'concept'
FROM topics WHERE name = 'Research Paradigms & Frameworks' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Distinguish Projective vs. Exploratory Technique',
  'Projective: Reveals unconscious feelings; uses word association, sentence completion, drawing; indirect method. Example: show faulty circuit image, ask "What is person thinking?" Exploratory: Investigates undefined problem as first step; uses interviews, focus groups, literature reviews; direct method. Example: Interview engineers about motor failure causes.',
  'hard',
  'comparison'
FROM topics WHERE name = 'Research Paradigms & Frameworks' LIMIT 1;

INSERT INTO flashcards (topic_id, question, answer, difficulty, type) 
SELECT id, 
  'Compare Validity and Reliability',
  'Validity: Measures what claims to measure (right thing?). Types: Internal (establishes causation), External (generalizable to other populations/settings). Reliability: Consistency/repeatability (same result under same conditions?). Example: Test of soldering skill must validly test skill not theory (validity) and consistently measure same skill level (reliability).',
  'hard',
  'comparison'
FROM topics WHERE name = 'Research Paradigms & Frameworks' LIMIT 1;
