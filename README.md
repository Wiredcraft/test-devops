# Test DevOps

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

A senior devops team member would be expected to perform the above and come back to the rest of the devops team with an educated suggestion as to use or not the proposed solution - a demo would be welcome.

## Extra

If there is a need for servers, let us know, we can provision boxes for the tests.
