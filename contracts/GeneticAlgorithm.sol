pragma solidity ^0.4.18;

contract GeneticAlgorithm {
    uint8 public genesCount = 9;

    function mixGenes(uint _sireGenes, uint _matronGenes) public returns (uint) {
        uint _genesToMixCount = uint(block.blockhash(block.number - 1)) % (genesCount - 3) + 3;
        uint8 _mixedGenesCount;
        uint _kittenGenes = _matronGenes;

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

    function _getGene(uint _genes, uint _geneIndex) internal returns (uint) {
        uint multi = genesCount - _geneIndex;
        uint rest = (_genes % (10 ** multi)) / 10 ** (multi - 1);

        return rest * (10 ** (multi - 1));
    }


    function _setGene(uint _genes, uint _gene, uint _geneIndex) internal returns (uint) {
        uint multi = genesCount - _geneIndex;
        uint part = _genes / (10 ** multi);
        uint part2 = _genes % (10 ** (multi - 1));
        uint res = part * (10 ** multi) + _gene + part2;

        return res;
    }
}