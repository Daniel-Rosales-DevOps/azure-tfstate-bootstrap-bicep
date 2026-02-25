# Terraform tfstate bootstrap (Bicep)
![](./chicken123.png)

This folder bootstraps an Azure Storage backend for Terraform state by creating:

- A Resource Group (RG)
- A Storage Account (StorageV2)
- Blob Storage containers

The deployment is safe to re-run: it should converge on the same resources (no duplicates) because the storage account name is generated deterministically in the template (prefix + stable suffix).

---

## Files

- `rg.sub.bicep`
  - Subscription-scope entrypoint
  - Creates the resource group and calls the resource-group scoped module

- `tfStorage.rg.bicep`
  - Resource-group-scope module
  - Creates the storage account and blob containers

- `tfstate.bicepparam`
  - Parameter file that holds the values for the setup/bootstrap
  - Provide your own values for setup or use the default values

### Caution

For normal usage, only change values in `tfstate.bicepparam`. Change the `.bicep` files only when you intentionally want to modify the bootstrap structure (and always run with `--confirm-with-what-if` first).

---

## Prereqs

- Azure CLI installed
- Logged in via Azure CLI (`az login`)

---

## Deploy

From this folder, run:

```bash
az deployment sub create \
  --name tfstate \
  --location swedencentral \
  --parameters tfstate.bicepparam \
  --confirm-with-what-if
```

#### What `--confirm-with-what-if` does

- Runs a “what-if” preview to show what Azure would create/change.
- Prompts you to confirm (`y/n`) before applying.

#### Why `--location swedencentral` is required here

This `--location` is the region Azure uses to store the deployment record/metadata for the subscription-scope deployment (basically the deployment “receipt” and history entry).
Pick a solid main location of previous deployments or future deployments. 

The actual region for the Resource Group and Storage Account is set in the `.bicepparam` under `param location = 'swedencentral'`
