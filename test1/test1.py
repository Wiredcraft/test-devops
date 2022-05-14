file_path = '../data/test-1-action-ids.log'

b = open('test-1-action-ids-output.txt', 'w')

with open(file_path, 'r') as a:
    # loop with iterator
    for i in a:
        replacedList = i.split(' = ')
        if replacedList[0] == 'replaced':
            replaced = eval(replacedList[1])
            # if 'ongoing' in replaced:
            if replaced[-1] == 'ongoing':
                actionId = eval(a.__next__().split(' = ')[1])
                b.write(f'{actionId}\n')

b.close()
