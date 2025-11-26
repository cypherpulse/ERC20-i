# BasedBradley (BBD) 🏆

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Solidity](https://img.shields.io/badge/Solidity-^0.8.18-blue.svg)](https://soliditylang.org/)
[![Foundry](https://img.shields.io/badge/Built%20with-Foundry-FF6B35.svg)](https://getfoundry.sh/)
[![Base Network](https://img.shields.io/badge/Network-Base-0052FF.svg)](https://base.org/)
[![Tests](https://img.shields.io/badge/Tests-Passing-brightgreen.svg)](https://github.com/cypherpulse/ERC20-i/actions)

> A premier ERC20 token on Base, engineered for security, scalability, and controlled tokenomics. Deployed across testnet and mainnet with institutional-grade standards.

## 🌟 Overview

BasedBradley (BBD) represents the next evolution in ERC20 token design, combining OpenZeppelin's battle-tested security with Base's lightning-fast Layer 2 infrastructure. As a controlled-mint token, BBD enables responsible token issuance while maintaining full ERC20 compatibility.

### ✨ Key Highlights
- **🔒 Security First**: Built on OpenZeppelin v5.0.2 with comprehensive access controls
- **⚡ High Performance**: Optimized for Base's low-latency, cost-effective transactions
- **🎯 Controlled Supply**: Owner-only minting prevents unauthorized inflation
- **🔍 Fully Audited**: Transparent, verifiable smart contracts
- **🌐 Cross-Platform**: Compatible with all major wallets and DeFi protocols

## 📊 Token Metrics

| Property | Value |
|----------|-------|
| **Token Name** | BasedBradley |
| **Symbol** | BBD |
| **Decimals** | 18 |
| **Initial Supply** | 1,000 BBD |
| **Total Supply** | Dynamic (Mintable) |
| **Network** | Base (Sepolia & Mainnet) |
| **Contract Standard** | ERC20 + Ownable |

## 🚀 Quick Start

Get up and running in minutes:

```bash
# Clone the repository
git clone https://github.com/cypherpulse/ERC20-i.git
cd ERC20-i

# Install dependencies
forge install

# Run tests
forge test

# Deploy to Base Sepolia
make deploy-base-sepolia
```

## 🏗️ Architecture

### Core Components

#### Smart Contracts
- **`BasedBradley.sol`**: Main ERC20 token contract with minting capabilities
- **`DeployBasedBradley.s.sol`**: Foundry deployment script

#### Key Features
- **ERC20 Compliance**: Full implementation of ERC20 standard
- **Ownable**: Secure owner-based access control
- **Mintable**: Controlled token creation
- **Gas Optimized**: Minimal gas usage for all operations

### Contract Interface

```solidity
interface IBasedBradley {
    function mint(address to, uint256 amount) external;
    function transfer(address to, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
}
```

## 🛠️ Development

### Prerequisites
- [Foundry](https://getfoundry.sh/) - Ethereum development toolkit
- [Git](https://git-scm.com/) - Version control
- [Node.js](https://nodejs.org/) (optional, for additional tooling)

### Environment Setup

1. **Clone and Install**
   ```bash
   git clone https://github.com/cypherpulse/ERC20-i.git
   cd ERC20-i
   forge install
   ```

2. **Configure Environment**
   ```bash
   cp .env.example .env
   # Edit .env with your credentials
   ```

3. **Import Keystore**
   ```bash
   cast wallet import defaultKey --interactive
   ```

### Available Commands

| Command | Description |
|---------|-------------|
| `make build` | Compile smart contracts |
| `make test` | Run test suite |
| `make deploy-base-sepolia` | Deploy to Base testnet |
| `make deploy-base-mainnet` | Deploy to Base mainnet |
| `make verify-base-sepolia` | Verify contract on testnet |
| `make verify-base-mainnet` | Verify contract on mainnet |

## 🧪 Testing

Comprehensive test coverage ensures reliability:

```bash
# Run all tests
forge test

# Run with gas reporting
forge test --gas-report

# Run specific test
forge test --mt testMint

# Generate coverage report
forge coverage
```

### Test Coverage
- ✅ ERC20 functionality (transfer, approve, transferFrom)
- ✅ Minting controls and restrictions
- ✅ Access control (owner-only operations)
- ✅ Edge cases and failure scenarios
- ✅ Gas optimization validation

## 🚀 Deployment

### Network Information

| Network | Chain ID | RPC URL | Explorer |
|---------|----------|---------|----------|
| Base Sepolia | 84532 | https://sepolia.base.org | [Sepolia Basescan](https://sepolia.basescan.org) |
| Base Mainnet | 8453 | https://mainnet.base.org | [Basescan](https://basescan.org) |

### Deployed Contracts

#### Base Sepolia (Testnet)
- **Contract Address**: `0xd84bcD574f34882BAc2eBfB61c29c9CC497aE0E8`
- **Explorer**: [View on Basescan](https://sepolia.basescan.org/address/0xd84bcD574f34882BAc2eBfB61c29c9CC497aE0E8)
- **Deployment Tx**: [View Transaction](https://sepolia.basescan.org/tx/0x00e3180ea2c32aa30564dc43617a57e8b250a2e3ace61a9f23ef0af58c830f57)

#### Base Mainnet (Production)
- **Contract Address**: `0x4c294b7A37C88dC2Cd01F915962CE78c3769EC4d`
- **Explorer**: [View on Basescan](https://basescan.org/address/0x4c294b7A37C88dC2Cd01F915962CE78c3769EC4d)
- **Deployment Tx**: [View Transaction](https://basescan.org/tx/0x4bfdec40054efa77f14c9ac7ca52bf77db9e847bc3aaad1dae4f97978bf32e5c)

### Automated Deployment

```bash
# Testnet deployment
make deploy-base-sepolia

# Mainnet deployment (requires funded wallet)
make deploy-base-mainnet
```

## 🔐 Security

### Audit Status
- ✅ **OpenZeppelin Contracts**: Audited and battle-tested
- ✅ **Access Controls**: Owner-only minting prevents unauthorized supply changes
- ✅ **Input Validation**: Comprehensive checks prevent common vulnerabilities
- 🔄 **External Audit**: Recommended for production use

### Security Features
- **Reentrancy Protection**: Inherited from OpenZeppelin ERC20
- **Overflow Protection**: Solidity ^0.8.0 built-in checks
- **Access Control**: Only owner can mint tokens
- **Transparent Code**: Fully open-source and verifiable

## 📈 Tokenomics

### Supply Mechanics
- **Initial Supply**: 1,000 BBD (minted to deployer)
- **Minting**: Controlled by contract owner
- **Burning**: Not implemented (can be added if needed)
- **Distribution**: Centralized ownership with controlled expansion

### Use Cases
- **DeFi Integration**: Compatible with Uniswap, lending protocols
- **Reward Systems**: Token-based incentives and rewards
- **Governance**: Foundation for DAO structures
- **Payments**: Fast, low-cost transactions on Base

## 🤝 Contributing

We welcome contributions from the community! See our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Workflow
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Standards
- Follow [Solidity Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html)
- Write comprehensive tests for new features
- Update documentation
- Ensure all CI checks pass

## 📄 License

Licensed under the [MIT License](LICENSE). See [LICENSE](LICENSE) for full terms.

## 📞 Contact & Support

- **GitHub Issues**: [Report bugs or request features](https://github.com/cypherpulse/ERC20-i/issues)
- **Discussions**: [Join community discussions](https://github.com/cypherpulse/ERC20-i/discussions)
- **Email**: [Contact maintainers](mailto:contact@cypherpulse.dev)

## 🔗 Links & Resources

- [Base Network Documentation](https://docs.base.org/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [Foundry Book](https://book.getfoundry.sh/)
- [ERC20 Standard](https://eips.ethereum.org/EIPS/eip-20)

## 🙏 Acknowledgments

- **OpenZeppelin**: For providing secure, audited smart contract libraries
- **Base**: For the high-performance Layer 2 infrastructure
- **Foundry**: For the exceptional Ethereum development toolkit

---

<div align="center">

**Built with ❤️ on Base by [CypherPulse](https://github.com/cypherpulse)**

[![GitHub stars](https://img.shields.io/github/stars/cypherpulse/ERC20-i.svg?style=social&label=Star)](https://github.com/cypherpulse/ERC20-i)
[![GitHub forks](https://img.shields.io/github/forks/cypherpulse/ERC20-i.svg?style=social&label=Fork)](https://github.com/cypherpulse/ERC20-i)

</div>
