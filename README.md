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
- In total of all our infrastructure work, it will cost around ~200$ a month- which most of it expenses are from the RDS. We wanted to make our project cheap and simple as much as possible so the costs are speaking to itself. Most of our machines are running on t3.medium or small which doesnt cost much and they can keep up on loading on them (and at the same time the LB and ASG are helping out). Our RDS turned to cost about 50$ a month (we used the smallest option of size type, we are aware of the free tier but it didnt seem to be affective in a production envirnoment- could be great for the testing though) and the elastic cache that turned 50$ due to a replica (so 1 is 25$ and together it will cost 50$). All the other costs are coming from the other platforms like WAF, LB, the instances, etc.


# *Documentation:*

- In this project we have gotten through some changes with our architecture which has been changed in the last 2 days of the project deadline that includes as can be seen in this repo- the docker compose. From the very first start we thought its better to create all our DB, redis and the app itself in one docker compose that will create 3 containers (due to thinking of making the project more simple with less infrastructure and cheaper) which indeed did work but that architecture is working the best for testing environment and not a production environment (as in if we have several servers that run the status page app- what will happen to our changes in DB if its in containers in docker compose and not in some type of RDS- which won't fit for production), so we have decided to change that and use RDS postgres and elastic cache for redis so the docker compose wasn't relevant anymore only the Dockerfile to build our app- it's indeed making the costs more expensive (mostly from the RDS) but now this project is much more compatible for production and for users using it.
So we can conclude that with the docker compose way of working, it fits more for our test environment and the RDS + elastic cache in exchange of the docker compose fits more for our production environment- by understanding that we can have two environment seperated by two VPCs for best practice and use each one for their own usage- one for the developers and one for our users.

#### Our CI/CD is built through github actions and we have our own runner server:
![image](https://user-images.githubusercontent.com/117725365/224488663-cc355fcd-1f1b-4974-b446-8e74300fff8a.png)

Our runner server has a chrone job that every 3 hours deleting unnecessary containers (due to running the jobs workflows on it, it takes a lot of space on it) and ease some load on the server. We start with building the image from the Dockerfile (after our developers committed to the main branch) and pushing it to our ECR with latest tag on that image (so each time we will take the image it will take the latest one we have with that tag)- that part is our CI part.
Afterwards the latest image is going through code deploy- which will deploy the image into our instaces that are running through ASG- first it goes into our testing environment to deploy there and see that everything went well with no errors, and using a testing stage that checks that indeed the app still has trace back to the internet and is up. After the testing in our test environment it does the same in the production- the code deploy deploys the latest image to the app (now after that we saw that were no errors in the testing environment we dont need to worry with problems with the latest image) and update our instances that are running the app with the new feature/update.


- We have learned a lot from this project and used many platforms and more new ones for us like the github actions that led us to understand it better. We went through a lot of trails and errors but we think that's how you learn the best from- we had a moto throughout the project "make it work then make it better" which helped us a lot and I think I will keep it to every place I would go to because it helps you see that the most important thing is to make the very first base of something to work and from there you can add features and updates. We saw that our architecture could change up (very flexiable) with changes (for example the drastic change from docker compose to the RDS and elastic cache) which showed up to work very well, and at the end creating our first ever full big project. We are aware that it is not a perfect project and we can add more stuff for it, such as we should have considered some type of Iac like terraform from the start so we could create all our infrastructure in one go no matter the situation and easier to change in but we learned from our path of that project and know how to work better on future projects.

*Thank you for your time*
