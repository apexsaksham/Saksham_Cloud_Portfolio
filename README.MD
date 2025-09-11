# 🚀 Personal Portfolio Deployment

This project demonstrates **automated deployment of a personal portfolio website** on AWS using **Terraform (IaC)** and **GitHub Actions (CI/CD)**.

The pipeline provisions cloud infrastructure, hosts the portfolio on **S3 (static hosting)**, distributes it globally using **CloudFront CDN**, and automates deployments via **GitHub Actions workflows**.

---

## 🏗️ Architecture

* **Frontend**: Static portfolio website (HTML/CSS/JS).
* **AWS S3**: Stores static website files.
* **AWS CloudFront**: Provides global CDN distribution for low latency.
* **Terraform**: Infrastructure as Code for reproducible deployments.
* **GitHub Actions**: CI/CD pipeline for automated provisioning & deployment.

```
Developer → GitHub → GitHub Actions → Terraform → AWS (S3 + CloudFront)
```

----

## ⚙️ Features

✅ Automated Infrastructure provisioning with **Terraform**
✅ Global content delivery via **CloudFront**
✅ Secure storage using **S3 Bucket** (static hosting)
✅ **CI/CD pipeline** using GitHub Actions:

* `terraform plan` runs on PR
* `terraform apply` runs on merge
  ✅ Modular Terraform structure for scalability

---

## 📂 Project Structure

```
├── .github/workflows/      # CI/CD pipelines (plan + apply)
├── modules/                # Terraform modules (S3, CloudFront, IAM, etc.)
├── main.tf                 # Root Terraform configuration
├── variables.tf            # Input variables
├── outputs.tf              # Output values
└── README.md               # Project documentation
```

---

## 🚀 Deployment Workflow

1. **Developer commits changes** → Push to GitHub
2. **GitHub Actions Workflow runs**

   * `terraform fmt` + `terraform validate`
   * `terraform plan` on PR (review changes)
   * `terraform apply` on merge to main
3. **AWS Infrastructure Updated**
4. Portfolio automatically deployed & served globally 🌍

---

## 🛠️ Prerequisites

* AWS account with IAM permissions
* Terraform >= 1.5
* GitHub repository with Actions enabled
* Portfolio static site code (HTML/CSS/JS)

---

## 📦 Setup Instructions

1. Clone the repository

   ```bash
   git clone https://github.com/apexsaksham/Saksham_Cloud_Portfolio.git
   cd portfolio-deployment
   ```
2. Configure AWS credentials (via GitHub Secrets or CLI).
3. Initialize Terraform

   ```bash
   terraform init
   ```
4. Run plan & apply

   ```bash
   terraform plan
   terraform apply
   ```
5. Access deployed site via **CloudFront distribution URL**.

---

## 🔄 CI/CD Pipeline

* **Pull Request (PR)** → Runs `terraform fmt`, `validate`, `plan`
* **Main Branch Merge** → Runs `terraform apply` to update AWS infra
* **Auto Deployment** → New portfolio changes go live via CloudFront

---

## 📈 Future Improvements

* Add **Route 53** for custom domain with HTTPS (ACM).
* Add monitoring with **CloudWatch**.
* Enhance security with **WAF**.
* Extend pipeline with **destroy workflow** for cleanups.

---

## 📌 Tech Stack

* **Cloud**: AWS (S3, CloudFront, IAM)
* **IaC**: Terraform
* **CI/CD**: GitHub Actions
* **Frontend**: HTML, CSS, Tailwind, JavaScript

---

## 👨‍💻 Author

**Saksham Singh**
🌐 [Portfolio Website](https://sakshamportfolio.cloud/)
💼 Cloud & DevOps Enthusiast | AWS | Terraform | CI/CD
