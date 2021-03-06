// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StrainzDNA {

    struct DNAData {
        uint potGene;
        uint headGene;
        uint bodyGene;
        uint faceGene;
        uint jointGene;
        uint sunglassesGene;
        uint earringGene;
        uint redGene;
        uint greenGene;
        uint blueGene;
    }

    function getGene(uint dna, uint n) public pure returns (uint) {
        return (dna / (10 ** (15 - n))) % 10;
    }


    function getBlueGene(uint dna) public pure returns (uint){
        return dna % 1000;
    }

    function getGreenGene(uint dna) public pure returns (uint) {
        return (dna % 1000000 - (dna % 1000)) / 1000;
    }

    function getRedGene(uint dna) public pure returns (uint) {
        return (dna % 1000000000 - (dna % 1000000)) / 1000000;
    }

    function mixDNA(uint dna1, uint dna2) public view returns (uint) {
        uint randomValue = random(256);
        DNAData memory data = DNAData(
            ((getGene(dna1, 0) * getGene(dna2, 0) * randomValue) % 7) + 1, // pot
            ((getGene(dna1, 1) * getGene(dna2, 1) * randomValue) % 7) + 1, // head
            ((getGene(dna1, 2) * getGene(dna2, 2) * randomValue) % 6) + 1, // body
            ((getGene(dna1, 3) * getGene(dna2, 3) * randomValue) % 5) + 1, // face
            0, // joint (not used)
            0, // sunglass (not used)
            0, // earring (not used)
            (getRedGene(dna1) * getRedGene(dna2) + randomValue) % 256, // red
            (getGreenGene(dna1) * getGreenGene(dna2) + randomValue) % 256, // green
            (getBlueGene(dna1) * getBlueGene(dna2) + randomValue) % 256 // blue
        );


        uint newDNA = ((10 ** 15) * data.potGene) + ((10 ** 14) * data.headGene) + ((10 ** 13) * data.bodyGene)
        + ((10 ** 12) * data.faceGene) + ((10 ** 11) * data.jointGene) + ((10 ** 10) * data.sunglassesGene) + ((10 ** 9) * data.earringGene)
        + ((10 ** 6) * data.redGene) + ((10 ** 3) * data.greenGene) + (data.blueGene % 256);

        return newDNA;
    }


    function clamp(uint value, uint min, uint max) public pure returns (uint) {
        return (value < min) ? min : (value > max) ? max : value;
    }

    function random(uint range) internal view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp))) % range;
    }

}
