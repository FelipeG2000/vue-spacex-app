## 🚀 Frontend Deployment: Vue + GitHub Actions + ECS Fargate

This Vue-based frontend is fully integrated with an automated CI/CD pipeline using **GitHub Actions**, deploying to **ECS Fargate** with Docker and Amazon ECR.


### 🌐 Live Demo
👉 [spacex-frontend-lb-1010699048.us-east-1.elb.amazonaws.com](http://spacex-frontend-lb-1010699048.us-east-1.elb.amazonaws.com)


### 🧰 Tech Stack
- Vue 3 + Vite
- Docker
- GitHub Actions
- Amazon ECS Fargate
- Amazon ECR
- Nginx
- Terraform 

### 📁 Project Structure

```bash
vue-spacex-app/
├── .github/workflows/
│   └── deploy-frontend.yml    # CI/CD pipeline configuration
├── src/
│   ├── components/
│   │   ├── LaunchTable.vue
│   │   └── StatusChart.vue
│   ├── App.vue
│   ├── main.js
│   └── style.css
├── dockerfile                 # Docker image definition for the frontend
├── nginx.conf                 # Nginx config for production
├── .env.production            # Automatically generated with the API URL
└── vite.config.js
```

## 🛠 Core Components
### App.vue
Root component that:

* Manages loading state

* Fetches data from API

* Distributes data to child components

### LaunchTable.vue
Interactive table displaying:

* Mission name

* Launch date

* Rocket name

* Launch status

### StatusChart.vue
Data visualization showing:

* Status distribution (success/failure/upcoming)

* Historical trends

## **Requires Node.js >= 18 and Vite**

### 📦 Local Development
To run this project locally:
```bash
git clone https://github.com/FelipeG2000/vue-spacex-app.git
cd vue-spacex-app
npm install
npm run dev
```
> ⚠️ **Important**:
> For the application to work locally, you need to provide a valid backend API URL from the deployed backend (e.g. from AWS API Gateway).
> 1. First, **fork and deploy the [backend repository](https://github.com/FelipeG2000/spacexback)**. This will generate your own API endpoint.
> 
> 2. Create a `.env` file in the root of the project with the following content:
>
> ```bash
> VITE_API_URL=https://<your-backend-api-url>
> # Replace `<your-backend-api-url>` with the actual URL from your deployed backend (e.g., `https://abcdefg.execute-api.us-east-1.amazonaws.com`).
> ```
> 
> This is required so the frontend app can correctly fetch the launch data from the backend during local development.

### 🧱 Infrastructure Provisioning (via Terraform)

You can deploy the entire frontend infrastructure (ECR, ECS Cluster, Task, Load Balancer, etc.) using Terraform.

From the infra/ folder:
```bash
cd infra
terraform init 
terraform apply
```


This command will output key information like:
 - Public Load Balancer DNS (access your app from here)
 - ECR Repository URL (used to push Docker image)

### 🛠 Deploy Script (Optional)
For manual deployments, a bash script (deploy.sh) is available to:

1. Fetch the backend API endpoint from CloudFormation.

2. Create .env.production with the correct VITE_API_URL.

3. Authenticate with ECR using AWS CLI.

4. Build and tag the Docker image.

5. Push to ECR.

6. Trigger aws ecs update-service to redeploy.

>⚠️ This script assumes that the infrastructure (ECR, ECS, etc.) is already provisioned via Terraform. It will not create any AWS resources — it only automates deployment steps.

### 🔐 Configure GitHub Actions (CI/CD)

After applying Terraform, configure GitHub Secrets and Variables in your frontend GitHub repository:

### 🔐 GitHub Secrets

| Secret Name            | Description                            |
|------------------------|----------------------------------------|
| `AWS_ACCESS_KEY_ID`    | AWS access key for authentication.     |
| `AWS_SECRET_ACCESS_KEY`| AWS secret key for authentication.     |
| `AWS_ACCOUNT_ID`       | Your 12-digit AWS Account ID.          |

### ⚙️ GitHub Repository Variables

| Variable Name   | Description                                                  |
|------------------|--------------------------------------------------------------|
| `REGION`         | `us-east-1`                               |
| `ECR_REPO`       | `spacex-frontend`              |
| `ECS_CLUSTER`    | `spacex-frontend-cluster`                 |
| `ECS_SERVICE`    | `spacex-frontend-service`                 |
| `STACK_NAME`     | `spacex-backend`   |

## ⚙️ CI/CD Pipeline (GitHub Actions)
Each push to the main branch automatically triggers the deployment pipeline, which performs the following steps:

1. Check out the source code.

2. Configure AWS credentials using aws-actions/configure-aws-credentials.

3. Fetch the API endpoint URL from CloudFormation (SpaceXLaunchesApiEndpoint).

4. Generate the .env.production file with VITE_API_URL for the production environment.

5. Authenticate with Amazon ECR.

6. Build the Docker image for the frontend.

7. Tag and push the image to ECR.

8. Deploy the application to ECS Fargate, forcing a new deployment for the service.

### 📄 File: .github/workflows/deploy-frontend.yml

This pipeline ensures the frontend is automatically updated in production with every change pushed to the main branch, enabling seamless continuous integration with AWS.

> Note: This CI/CD pipeline assumes that the ECS Cluster, Task Definition, and Service have been pre-configured (either manually via the AWS Console or through Infrastructure as Code). The aws ecs update-service command will trigger a new deployment using the latest Docker image from Amazon ECR.

## 🧼 Future Improvements
- Add unit tests for core components
- Handle API error states more gracefully
- Add pagination to LaunchTable
