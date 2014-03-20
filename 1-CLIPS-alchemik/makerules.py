import re

# [TODO] -- consider using PyClips. Maybe implement two versions?

clips_init_template = """
(deffacts primary_elements
  (air)
  (earth)
  (fire)
  (water)
)

"""

clips_rule_template = """
(defrule %s-%s-%s
  (%s)
  (%s)
  =>
  (assert (%s))
)

"""

clips_ending_template = """
(reset)

"""


def create_clips_defrule(a, b, c):
    return clips_rule_template % (a, b, c, b, c, a)


def create_clips_defrules(clips_defrules_tuples):
    clips_defrules = ""
    for (a, b, c) in clips_defrules_tuples:
        clips_defrules += create_clips_defrule(a, b, c)

    return clips_defrules


def clips_complete_source_code(clips_init, clips_defrules, clips_ending):
    return clips_init + clips_defrules + clips_ending


def rules_tuples_from_file(filepath):
    f = open(filepath, 'r')
    lines = f.read().lower().splitlines()

    abc = re.compile(r"\d+[.]\s+(\w+)\s+[=]\s+(\w+)\s+[+]\s+(\w+)")
    clips_defrules_tuples = []
    for line in lines:
        match = abc.search(line) 
        if match:
            (a, b, c) = (match.group(1), match.group(2), match.group(3))
            clips_defrules_tuples.append((a, b, c))

    return clips_defrules_tuples


tuples = rules_tuples_from_file('alchemy-rules.txt')
clips_defrules_str = create_clips_defrules(tuples)
clips = clips_complete_source_code(clips_init_template, clips_defrules_str, clips_ending_template)

print(clips)



