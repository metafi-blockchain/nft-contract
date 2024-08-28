include .env

deploy-sepolia:
	@echo "Deploying to Sepolia Network"
	@forge script script/EnteralKingdomNFTFactory.s.sol --rpc-url ${RPC_SEPOLIA_NETWORK} --broadcast --account test-sepolia