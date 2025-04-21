## 🚀 Frontend Deployment: Vue + GitHub Actions + ECS Fargate

This Vue-based frontend is fully integrated with an automated CI/CD pipeline using **GitHub Actions**, deploying to **ECS Fargate** with Docker and Amazon ECR.


### 🌐 Live Demo
👉 [http://44.204.83.107/](http://44.204.83.107/)


### 🧰 Tech Stack
- Vue 3 + Vite
- Docker
- GitHub Actions
- Amazon ECS Fargate
- Amazon ECR
- Nginx


## **Requires Node.js >= 18 and Vite**
### 📦 Local Development
```bash
git clone https://github.com/your-username/vue-spacex-app.git
cd vue-spacex-app
npm install
npm run dev
```
> ⚠️ If you fork this repository and wish to deploy to your own AWS environment:
> 
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
>
> 3. Then, **set up the following secrets and variables in your forked frontend repo**:
>    - GitHub Secrets:
>      - `AWS_ACCESS_KEY_ID`
>      - `AWS_SECRET_ACCESS_KEY`
>    - GitHub Repository Variables:
>      - `REGION`
>      - `ECR_REPO`
>      - `STACK_NAME`
>      - `ECS_CLUSTER`
>      - `ECS_SERVICE`
> 
> These are required so GitHub Actions can fetch the correct API URL and deploy successfully to your infrastructure.




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

## 🧼 Future Improvements
- Add unit tests for core components
- Handle API error states more gracefully
- Add pagination to LaunchTable
