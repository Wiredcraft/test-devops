# Wiredcraft DevOps test

Make sure you read **all** of this document carefully, and follow the guidelines in it.

## Background

The DevOps work at Wiredcraft is involving a lot of:

1. automation (scripts, ansible, etc.)
2. discovery (need for clarification)
3. new technologies (need to evaluate a technology)

The purpose of this test is to:

- evaluate your technical knowledge
- evaluate your communication with the team
- evaluate your ability to learn
 
## Preamble
 
The DevOps needs extend from basic deploy / monitoring / operation / testing to more broad areas like R&D. 

The dev and devops teams are working together during the building phases for either services or products, and often come up with existing solutions that need to be evaluated and vetted for when it comes to long term management / performance, scalability.

[Kong](https://getkong.org) is a solution based on top of Nginx/Lua and Cassandra to improve security and management of backend APIs. It offers a wide range of [plugins](https://getkong.org/plugins/) from auth to logging that made its use attractive. It would have to be managed / setup by the devops team and would have to collaborate closely with the dev team when it comes to the feature set and feasibility. 

## Tasks

We need to figure a few things: 

- how complex is the setup of Kong,
- how accurate is the available documentation,
- how many servers would be required for optimal use and scalability,
- create a CentOS based role / setup (an existing one for [Ubuntu](https://galaxy.ansible.com/jessem/kong/) already exist and could be adapted)
- prepare a test platform to evaluate the solution
- evaluate manageability: add / remove plugins - log management - etc.

The dev needs are:

- oAuth2 login
- log to syslog
- rate limit
- ACL / CORS / SSL

A devops team member would be expected to perform the above and come back to the rest of the devops team with an educated suggestion as to use or not the proposed solution - a demo would be welcome.

# Getting Started

There's nothing here, we leave it to you to choose the build tool, code structure, framework, testing approach...

# Requirements

- With clear documentation on how to run the code
- Use git to manage code

# What We Care About

Feel free to schedule your work, ask questions.

We're interested in your method and how you approach the problem just as much as we're interested in the end result.

Here's what you should aim for:

- Comments in your scripts
- Comments in your playbooks
- Clean README file that explains how things work
- Extensible work / code (use variables, limit hardcoded values, etc.) 

# Q&A

- Where should I send back the result when I'm done?
Fork this repo and send us a pull request when you think you are done. We don't have deadline for the task.

- What if I have question?
Create a new issue in the repo and we will get back to you very quickly. You can also jump on Slack and talk with us.

# Extra

If there is a need for servers, let us know, we can provision boxes for the tests.


