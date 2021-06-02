
import datetime
import json
import subprocess
year=2021
startweek= 22
endweek= 52
sprintlen=2
sprintno = 17
sprintday = 1 # mon = 1 
r = range(startweek,endweek,sprintlen)
sprints=[]
fortune = True

for s in r:
    wd = f'{year}-W{s}-{sprintday}T23:59:59'
    d = datetime.datetime.strptime(wd,"%Y-W%W-%wT%H:%M:%S")
    if d > datetime.datetime.now():
        state = "open"
    else:
        state = "closed"
    state = "absent"
    if fortune:
        try:
            desc = subprocess.run(['fortune', '-s','computers'], stdout=subprocess.PIPE).stdout.decode('utf-8')
        except FileNotFoundError:
            desc = ""
            print("fortune not found.. boring")
            fortune = False

    sprints.append({ 'title' : f'sprint {sprintno}',
                     'state' : state,
                     'description': desc,
                     'due_on' : d.isoformat()
                     })
    sprintno = sprintno + 1 
#   {
#     "title": "Sprint 8",
#     "state": "closed",
#     "description": "What was our resolution again?",
#     "due_on": "2021-01-25T23:59:59Z"
#   },

print(json.dumps(sprints))