pragma solidity ^0.4.18;

contract GeneticAlgorithm {
    uint8 public genesCount = 9;
    uint8 public geneLength = 2;

    function mixGenes(string _sireGenes, string _matronGenes) public returns (string) {
        uint _genesToMixCount = uint(block.blockhash(block.number - 1)) % (genesCount + 1) + 3;
        uint8 _mixedGenesCount;
        string memory _kittenGenes = _matronGenes;

        bytes32 _randomHash = keccak256(block.blockhash(block.number - 1));

        uint _randomGeneIndex;
        while (_mixedGenesCount < _genesToMixCount) {
            _randomGeneIndex = uint(_randomHash) % genesCount;

            _kittenGenes = _setGene(_kittenGenes, _getGene(_sireGenes, _randomGeneIndex), _randomGeneIndex);

            _randomHash = keccak256(_randomHash);
            _mixedGenesCount++;
        }

        return _kittenGenes;
    }

    function _getGene(string _genes, uint _geneIndex) internal returns (bytes _gene) {
        _gene = "00";
        for (uint i = 0; i < geneLength; i++) {
            _gene[i] = bytes(_genes)[_geneIndex + i];
        }

    }


    function _setGene(string _genes, bytes _gene, uint _geneIndex) internal returns (string) {
        for (uint i = 0; i < geneLength; i++) {
            bytes(_genes)[_geneIndex * 2 + i] = _gene[i];
        }

        return _genes;
    }
}