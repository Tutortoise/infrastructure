# Infrastructure

This repository contains the infrastructure-as-code (IaC) setup using **[Terraform](https://www.terraform.io/)** to provision and manage resources.

## Prerequisites

### 1, Required Tools

- [Terraform](https://www.terraform.io/) - v1.9.8 or later
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) - 502.0.0 or later

### 2. Access Credentials

Before you can use terraform you need to authenticate with gcloud sdk

```bash
gcloud auth application-default login
```

### 3. Terraform Backend

Create a Google Cloud Storage bucket if you don't have one already. This bucket will be used as the backend to store the terraform state file.

```bash
gsutil mb -p your-project-id -l asia-southeast2 gs://tutortoise-terraform
```

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/Tutortoise/infrastructure.git
cd  https://github.com/Tutortoise/infrastructure.git
```

### 2. Initialize Terraform

```bash
terraform init
```

This command will download and intialize the required providers and modules.

### 3. Configure the Variables

copying the `terraform.tfvars.example` file to `terraform.tfvars` and modifying the values.

```hcl
project_id = "your-project-id"
region = "asia-southeast2"
```

### 4. Plan the Changes

Run the following command to preview the infrastructure changes:

```bash
terraform plan
```

### 5. Apply the Changes

Deploy the infrastructure with:

```bash
terraform apply
```

Confirm the changes when prompted.
