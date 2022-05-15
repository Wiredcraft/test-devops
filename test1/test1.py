file_path = '../data/test-1-action-ids.log'

b = open('test-1-action-ids-output.txt', 'w')

with open(file_path, 'r') as a:

    # loop with iterator
    for i in a:
        # split line:
        # ['replaced', '[{"id":"1e5b4585-de68-4fe9-84b8-9deb071aa148","status":"finished","accexp":15},
        # {"id":"1e5b4585-de68-4fe9-84b8-9deb071aa148","status":"finished","accexp":10},
        # {"id":"1e5b4585-de68-4fe9-84b8-9deb071aa148","status":"finished","accexp":10},
        # {"id":"1e5b4585-de68-4fe9-84b8-9deb071aa148","status":"finished","accexp":5},
        # {"id":"1e5b4585-de68-4fe9-84b8-9deb071aa148","status":"finished","accexp":20},
        # {"id":"1e5b4585-de68-4fe9-84b8-9deb071aa148","status":"finished","accexp":20}]\n']
        replacedList = i.split(' = ')
        # check list[0] contains 'replaced'
        if replacedList[0] == 'replaced':
            # use eval to convert string to list
            replaced = eval(replacedList[1])
            # check this list contains string 'ongoing'
            # if 'ongoing' in replaced:
            if replaced[-1] == 'ongoing':
                # if this list contains string 'ongoing'. Use method __next__() to get next line(acitonId).
                # Then use eval convert string to list
                actionId = eval(a.__next__().split(' = ')[1])
                b.write(f'{actionId}\n')

b.close()
