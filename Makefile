-include .env

.PHONY: all test test-zk clean deploy fund help install snapshot format anvil install deploy deploy-zk deploy-zk-sepolia deploy-sepolia verify

DEFAULT_ANVIL_KEY :=
DEFAULT_ZKSYNC_LOCAL_KEY :=

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

test-zk :; foundryup-zksync && forge test --zksync && foundryup

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

deploy:
	@forge script script/DeployOurToken.s.sol:DeployOurToken --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast


deploy-sepolia:
	@forge script script/DeployOurToken.s.sol:DeployOurToken --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT) --sender $(SENDER) --etherscan-api-key $(ETHERSCAN_API_KEY) --broadcast --verify

deploy-zk:
	@forge script script/DeployOurToken.s.sol --rpc-url http://127.0.0.1:8011 --private-key $(DEFAULT_ZKSYNC_LOCAL_KEY) --legacy --zksync

deploy-zk-sepolia:
	@forge script script/DeployOurToken.s.sol --rpc-url $(ZKSYNC_SEPOLIA_RPC_URL) --account $(ACCOUNT) --legacy --zksync

deploy-zk-bad:
	@forge script script/DeployOurToken.s.sol --rpc-url https://sepolia.era.zksync.dev --private-key $(PRIVATE_KEY) --legacy --zksync

verify:
	@forge verify-contract --chain-id 11155111 --num-of-optimizations 200 --watch --constructor-args 0x00000000000000000000000000000000000000000000d3c21bcecceda1000000 --etherscan-api-key $(ETHERSCAN_API_KEY) --compiler-version v0.8.19+commit.7dd6d404 0x089dc24123e0a27d44282a1ccc2fd815989e3300 src/OurToken.sol:OurToken

deploy-base-sepolia:
    @forge script script/DeployBasedBradley.s.sol:BasedBradleyToken --rpc-url https://sepolia.base.org --account $ACCOUNT --sender $SENDER --etherscan-api-key $BASESCAN_API_KEY --broadcast --verify
# Deploy to Base Mainnet using keystore
deploy-base-mainnet:
    @forge script script/DeployBasedBradley.s.sol:BasedBradleyToken --rpc-url https://mainnet.base.org --account $(ACCOUNT) --sender $(SENDER) --etherscan-api-key $(BASESCAN_API_KEY) --broadcast --verify

# Verify on Base Sepolia
verify-base-sepolia:
    @forge verify-contract --chain-id 84532 --num-of-optimizations 200 --watch --constructor-args 0x00000000000000000000000000000000000000000000d3c21bcecceda1000000 --etherscan-api-key $(BASESCAN_API_KEY) --compiler-version v0.8.19+commit.7dd6d404 <CONTRACT_ADDRESS> src/BasedBradley.sol:BasedBradley

# Verify on Base Mainnet
verify-base-mainnet:
    @forge verify-contract --chain-id 8453 --num-of-optimizations 200 --watch --constructor-args 0x00000000000000000000000000000000000000000000d3c21bcecceda1000000 --etherscan-api-key $(BASESCAN_API_KEY) --compiler-version v0.8.19+commit.7dd6d404 <CONTRACT_ADDRESS> src/BasedBradley.sol:BasedBradley
