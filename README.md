# 🧱 Foundry + Story Protocol Project

This repository sets up a smart contract development environment using **Foundry** and integrates **Story Protocol** for IP asset registration and licensing on-chain.

---

## 📦 Setup Guide

### ✅ Prerequisites

- [Foundry](https://book.getfoundry.sh/) (install via Git Bash or WSL on Windows)
- [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/) (⚠️ required — avoid npm due to resolution issues)

---

### 🔧 Installation & Initialization

#### 1. Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

#### 2. Initialize Project

```bash
forge init
cd your-project
yarn init
```

#### 3. Replace `foundry.toml`

```toml
[profile.default]
out = 'out'
libs = ['node_modules', 'lib']
cache_path  = 'forge-cache'
gas_reports = ["*"]
optimizer = true
optimizer_runs = 20000
test = 'test'
solc = '0.8.26'
fs_permissions = [{ access = 'read', path = './out' }, { access = 'read-write', path = './deploy-out' }]
evm_version = 'cancun'
remappings = [
    '@openzeppelin/=node_modules/@openzeppelin/',
    '@storyprotocol/core/=node_modules/@story-protocol/protocol-core/contracts/',
    '@storyprotocol/periphery/=node_modules/@story-protocol/protocol-periphery/contracts/',
    'erc6551/=node_modules/erc6551/',
    'forge-std/=lib/forge-std/src/',
    'ds-test/=node_modules/ds-test/src/',
    '@storyprotocol/test/=node_modules/@story-protocol/protocol-core/test/foundry/',
    '@solady/=node_modules/solady/'
]
```

#### 4. Remove Example Contracts

```bash
rm src/Counter.sol script/Counter.s.sol test/Counter.t.sol
```

---

### 📚 Install Dependencies

```bash
# Core & Periphery Modules
yarn add @story-protocol/protocol-core@https://github.com/storyprotocol/protocol-core-v1
yarn add @story-protocol/protocol-periphery@https://github.com/storyprotocol/protocol-periphery-v1

# Supporting Libraries
yarn add @openzeppelin/contracts
yarn add @openzeppelin/contracts-upgradeable
yarn add erc6551
yarn add solady

# Dev Dependencies
yarn add -D https://github.com/dapphub/ds-test
yarn add -D github:foundry-rs/forge-std#v1.7.6
```

---

## ❗ Troubleshooting & IDE Issues

You might face IDE issues like:

```solidity
import {Test} from "forge-std/Test.sol";
```

showing red squiggly lines. **This is not a syntax error.** It's due to the IDE not resolving remappings.

✅ **Fix it:**

```bash
forge remappings > remappings.txt
```

---

## 🧪 Story Protocol Test Suite

This repo contains Foundry tests for interacting with [Story Protocol](https://docs.story.foundation/) on the Aeneid Testnet.

### 1. `test/0_IPARegistrar.t.sol`

Tests:

- Deploying SPG NFT via `RegistrationWorkflows`
- Minting NFTs
- Registering IP Assets

**Run:**

```bash
forge test --fork-url https://aeneid.storyrpc.io/ --match-path test/0_IPARegistrar.t.sol
```

---

### 2. `test/1_LicenseTerms.t.sol`

Tests:

- Registering PIL license terms
- Setting revenue token & royalty policies

**Run:**

```bash
forge test --fork-url https://aeneid.storyrpc.io/ --match-path test/1_LicenseTerms.t.sol
```

---

Here's a matching test file description and run command for each of the contracts you provided:

---

### 3. `test/2_AttachTerms.t.sol`

**Tests:**

* Deploying a mock `SimpleNFT` contract
* Minting a token to the IP owner (`tusharpamnani`)
* Registering the minted NFT as an IP asset using `IPAssetRegistry`
* Registering `PIL` license terms (Commercial Remix flavor)
* Attaching the license terms to the registered IP Asset via `LicensingModule`
* Verifying license attachment with assertions from `LicenseRegistry`

**Run:**

```bash
forge test --fork-url https://aeneid.storyrpc.io/ --match-path test/2_AttachTerms.t.sol
```

---

### 4. `test/3_LicenseToken.t.sol`

**Tests:**

* Deploying a mock `SimpleNFT` contract
* Minting a token and registering it as an IP asset
* Registering commercial remix license terms via `PILTemplate`
* Attaching license terms to the IP asset via `LicensingModule`
* Minting license tokens (2 tokens) to another user (`bob`)
* Verifying token ownership using `LicenseToken`'s `ownerOf`

**Run:**

```bash
forge test --fork-url https://aeneid.storyrpc.io/ --match-path test/3_LicenseToken.t.sol
```

---

### 5. `test/4_IPARemix.t.sol`

**Tests:**

* Deploying a mock `SimpleNFT` contract
* Minting a token to `alice` and registering it as an IP asset
* Registering commercial remix license terms via `PILTemplate`
* Attaching license terms to `alice`'s IP asset
* Minting license tokens (2) to `bob`
* `bob` mints and registers a derivative IP asset using his license token
* Asserts parent-child relationship in the license registry

**Run:**

```bash
forge test --fork-url https://aeneid.storyrpc.io/ --match-path test/4_IPARemix.t.sol
```

---

### 6. `test/Example.t.sol`

**Tests:**

* Deploying a mock `SimpleNFT` contract via the `Example` contract

* Running `mintAndRegisterAndCreateTermsAndAttach()`:

  * Mints an NFT to `tusharpamnani`
  * Registers it as an IP asset
  * Creates PIL license terms
  * Attaches license terms to the IP asset

* Validates correct attachment via `LicenseRegistry`

* Running `mintLicenseTokenAndRegisterDerivative()`:

  * Mints license token based on parent IP asset
  * Registers a new child IP asset derived from the parent
  * Validates parent-child relationship in the `LicenseRegistry`

**Run:**

```bash
forge test --fork-url https://aeneid.storyrpc.io/ --match-path test/Example.t.sol
```

---

## 🔗 Aeneid Testnet Contract Addresses

| Contract              | Address                                      |
| ---------------------|----------------------------------------------|
| IPAssetRegistry       | `0x77319B4031e6eF1250907aa00018B8B1c67a244b` |
| RegistrationWorkflows | `0xbe39E1C756e921BD25DF86e7AAa31106d1eb0424` |
| PILicenseTemplate     | `0x2E896b0b2Fdb7457499B56AAaA4AE55BCB4Cd316` |
| RoyaltyPolicyLAP      | `0xBe54FB168b3c982b7AaE60dB6CF75Bd8447b390E` |
| MERC20 Token          | `0xF2104833d386a2734a4eB3B8ad6FC6812F29E38E` |

---

## 🗂 File Structure

```
tests/
├── 0_IPARegistrar.t.sol       # Register IP asset
├── 1_LicenseTerms.t.sol       # Register license terms
├── 2_AttachTerms.t.sol        # Attach license terms to IP asset
├── 3_LicenseToken.t.sol       # Mint license tokens for an IP asset
├── 4_IPARemix.t.sol           # Register derivative IP asset using license token
└── Example.t.sol              # Full flow: mint, register, license, attach, remix
```

---

## 🚀 Quick Start

```bash
forge install
forge test --fork-url https://aeneid.storyrpc.io/
```

---

## 🚢 Deployment Guide

To deploy your smart contracts on the **Aeneid Testnet**, follow these steps:

### 1. 🦊 Install MetaMask

If not already installed, download MetaMask for Chrome from [https://metamask.io/download](https://metamask.io/download)

### 2. 🔑 Export Your Private Key

* Open MetaMask
* Click the **three dots** in the top-right corner of your account card
* Click **Account Details**
* Click **Export Private Key** and **copy it**

⚠️ **Do not share this private key** — treat it like a password.

### 3. 📄 Create `.env` File

In your project root, create a `.env` file with the following content:

```env
PRIVATE_KEY=<your_private_key>
```

> Replace `<your_private_key>` with the one you copied from MetaMask.

---

### 4. ✅ Load Environment Variables

Before running the deploy command, load your `.env` variables:

```bash
source .env
```

---

### 5. 🚀 Deploy with Foundry

Use the following command to deploy your contract and verify it on **StoryScan**:

```bash
forge create \
  --rpc-url https://aeneid.storyrpc.io/ \
  --private-key $PRIVATE_KEY \
  ./src/Example.sol:Example \
  --broadcast \
  --verify \
  --verifier blockscout \
  --verifier-url https://aeneid.storyscan.io/api/ \
  --constructor-args \
    0x77319B4031e6eF1250907aa00018B8B1c67a244b \
    0x04fbd8a2e56dd85CFD5500A4A4DfA955B9f1dE6f \
    0x2E896b0b2Fdb7457499B56AAaA4AE55BCB4Cd316 \
    0xBe54FB168b3c982b7AaE60dB6CF75Bd8447b390E \
    0xF2104833d386a2734a4eB3B8ad6FC6812F29E38E
```

✅ If everything worked correctly, you should see something like Deployed to: `0x354EcEb2bd747ec0d4acC370b77Fe28415F4f220` in the console. Paste that address into [the explorer](https://aeneid.storyscan.io/) and see your verified contract!

---

```bash
[⠊] Compiling...
No files changed, compilation skipped
Deployer: 0x87620f4Ec075ea5756b00BD5DE6472b4AFe5440b
Deployed to: 0x354EcEb2bd747ec0d4acC370b77Fe28415F4f220
Transaction hash: 0x5c8ed2190ac5d5ccbe972b9c7af639f49d79847293b7d8a36e426219a234020b
Starting contract verification...
Waiting for blockscout to detect contract deployment...
Start verifying contract `0x354EcEb2bd747ec0d4acC370b77Fe28415F4f220` deployed on 1315
Compiler version: 0.8.26
Constructor args: 00000000000000000000000077319b4031e6ef1250907aa00018b8b1c67a244b00000000000000000000000004fbd8a2e56dd85cfd5500a4a4dfa955b9f1de6f0000000000000000000000002e896b0b2fdb7457499b56aaaa4ae55bcb4cd316000000000000000000000000be54fb168b3c982b7aae60db6cf75bd8447b390e000000000000000000000000f2104833d386a2734a4eb3b8ad6fc6812f29e38e

Submitting verification for [src/Example.sol:Example] 0x354EcEb2bd747ec0d4acC370b77Fe28415F4f220.
Submitted contract for verification:
        Response: `OK`
        GUID: `354eceb2bd747ec0d4acc370b77fe28415f4f220684bfb18`
        URL: https://aeneid.storyscan.io/address/0x354eceb2bd747ec0d4acc370b77fe28415f4f220
Contract verification status:
Response: `OK`
Details: `Pending in queue`
Warning: Verification is still pending...; waiting 15 seconds before trying again (7 tries remaining)
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
```

This is what the output will look like after a successful deployment

---

## 🙋‍♂️ Author

**Tushar Pamnani** — [@tusharpamnani](https://github.com/tusharpamnani)

