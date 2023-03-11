### (This README file is still in progress)

# *Bootcamp Final Project: Building and Deploying Cloud-Based Application on AWS Architecture with Efficient CI/CD Pipelines.*
**(The source code for the application originates from the following GitHub repository: https://github.com/status-page/status-page).**

Our project had three primary objectives in mind, which were to prioritize:
- efficiency
- cost-effectiveness
- high availability and scalability

#### The architecture we built on AWS looks like this:
![arch](https://user-images.githubusercontent.com/117725271/224322465-470708e5-7b32-4497-b987-f4a9099d25e5.png)

#### Security:
- We separated the database, application, and public subnets, and placed the application servers in private subnets that were only reachable through a bastion host. This enhanced the overall security posture of the system and reduced the attack surface.
- we implemented specific security rules for each type of instance in order to isolate them and minimize the chances of opening unnecessary ports. This further increased the security of the architecture and helped to mitigate potential threats.
- To further strengthen our security measures, we implemented a Web Application Firewall (WAF) with our load balancer. The WAF provided protection against SQL injection attacks and anonymous connections to our application (such as VPN), while also defending against bot attacks. Additionally, we incorporated a CAPTCHA feature to make our system even more resistant to unauthorized access attempts. 

- Due to time constraints and a deadline, we made some compromises with regards to the security of our CI and test servers. Specifically, we were not able to fully isolate the test environment and had to place the test and CI server in public subnets.

#### Availability:
- To ensure maximum availability of our system, we have adopted a multi-AZ deployment approach. This approach involves replicating our infrastructure across multiple Availability Zones (AZs) in a given region, providing resiliency and redundancy in the event of a single AZ failure.
- In order to distribute traffic evenly across various instances running in our two Availability Zones (AZs), we implemented an Application Load Balancer (ALB). It allowed us to effectively manage traffic, ensure high availability, and optimize performance by routing requests to the most appropriate target instances.

#### Scalability:
- By deploying our application in an Auto Scaling Group, we gained the benefits of flexibility and scalability as needed. The ASG allowed us to automatically adjust the number of instances running our application in response to changes in demand, ensuring that we could meet our performance and capacity requirements at all times. Additionally, the ASG ensured that we had a reliable and fault-tolerant architecture, by automatically replacing unhealthy instances.

#### Cost-effectiveness:
- In total of all our infrastructure working, it will cost ~200$ a month 

#### Documentation:
- In this project we have gotten through some changes with our arcitecture which has been changed in the last 2 days of the project deadline that includes as can be seen in this repo- the docker compose. From the very first start we thought its better to create all our DB, redis and the app itself in one docker compose that will create 3 containers (due to thinking of making the project more simple with less infrastrucutre and cheaper) which indeed did work but that arcitecture is working the best for testing and not a production enviroment (as in if we have several servers that run the status page app- what will happen to our changes in DB if its in containers in docker compose and not in some type of RDS), so we have decided to change that and use RDS postgres and elastic cache for redis so the docker compose wasnt relevant anymore only the Dockerfile to build our app- it's indeed making the costs go up (mostly from the RDS) but now this project is much more compatible for production and for users using it.
So we can conclude that with the docker compose working, it fits more for our test environment and the RDS + elastic cache in excahnge of the docker compose fits more for our production environment- by understanding that we can have two environment seperated by VPC for best practice and use each one for their usage- one for the developers and one for our clients.
- Our CI/CD is built through github actions and we have our own runner server:

