import fs from 'fs';
import bip39 from 'bip39';
import bs58 from 'bs58';
import { Keypair } from '@solana/web3.js';

// Your seed phrase
const seedPhrase = 'xxxx yyyy zzzz ...';

// Convert seed phrase to seed buffer
const seed = bip39.mnemonicToSeedSync(seedPhrase).slice(0, 32);

// Generate keypair from seed
const keypair = Keypair.fromSeed(seed);

// Prepare keypair data to save as JSON
const keyData = {
    publicKey: keypair.publicKey.toBase58(),
    privateKey: bs58.encode(keypair.secretKey)
};

// Save keypair to id.json
fs.writeFileSync('keypair.json', JSON.stringify(Array.from(keypair.secretKey)));
fs.writeFileSync('key.json', JSON.stringify(keyData, null, 2));

console.log('Keypair saved to id.json');
