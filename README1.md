# 📚 Story Protocol Test Suite

This repository contains Foundry tests for interacting with [Story Protocol](https://docs.story.foundation/) smart contracts. These tests demonstrate how to register IP assets and license terms using the Story Protocol core and periphery contracts on the Aeneid testnet.

---

## 🧪 Tests Overview

### 1. `test/0_IPARegistrar.t.sol` — IP Asset Registration

This test script demonstrates:

- Deploying a new NFT collection using `RegistrationWorkflows`
- Minting an NFT to a recipient
- Registering the NFT as an IP asset on-chain

**Key Contracts Used:**

- `IRegistrationWorkflows`: Creates SPG NFT collections and registers IP.
- `ISPGNFT`: Interface for the NFT collection.
- `IIPAssetRegistry`: Used to verify the IP asset ID after registration.

**Run it with:**

```bash
forge test --fork-url https://aeneid.storyrpc.io/ --match-path test/0_IPARegistrar.t.sol
````

### 2. `test/1_LicenseTerms.t.sol` — License Terms Registration

This test demonstrates how to register new [PIL License Terms](https://docs.story.foundation/protocol/modules/licensing/pil-terms/) on-chain.

**Highlights:**

* Registers commercial and derivative-friendly license terms
* Uses the `PILicenseTemplate` contract
* Sets the revenue token (MERC20) and royalty policy (LAP)
* Makes license terms transferable, renewable, and open

**Key Contracts Used:**

* `IPILicenseTemplate`: Registers and fetches license term IDs.
* `PILTerms`: Struct for defining license parameters.

**Run it with:**

```bash
forge test --fork-url https://aeneid.storyrpc.io/ --match-path test/1_LicenseTerms.t.sol
```

---

## 🧑‍💻 Addresses Used (Aeneid Testnet)

| Contract              | Address                                      |
| --------------------- | -------------------------------------------- |
| IPAssetRegistry       | `0x77319B4031e6eF1250907aa00018B8B1c67a244b` |
| RegistrationWorkflows | `0xbe39E1C756e921BD25DF86e7AAa31106d1eb0424` |
| PILicenseTemplate     | `0x2E896b0b2Fdb7457499B56AAaA4AE55BCB4Cd316` |
| RoyaltyPolicyLAP      | `0xBe54FB168b3c982b7AaE60dB6CF75Bd8447b390E` |
| MERC20 Token          | `0xF2104833d386a2734a4eB3B8ad6FC6812F29E38E` |

---

## 📂 File Structure

```
tests/
├── 0_IPARegistrar.t.sol       # Test for registering an IP asset
└── 1_LicenseTerms.t.sol       # Test for registering PIL license terms
```

---

## ✅ Prerequisites

* [Foundry](https://book.getfoundry.sh/)
* RPC endpoint for Aeneid network (`https://aeneid.storyrpc.io/`)

---

## 🛠️ Setup

```bash
forge install
forge test --fork-url https://aeneid.storyrpc.io/
```

---

## 🙋‍♂️ Author

Tushar Pamnani — [@tusharpamnani](https://github.com/tusharpamnani)
