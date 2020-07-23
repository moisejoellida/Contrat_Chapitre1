// nous devons spécifier la version de compilation de notre cod

pragma solidity ^0.6.4;

contract Voting{
    //le champ de mapage ci-dessous equivaut à un tableau associatif ou un hachage
    //la cle du mapage est le nom du contract stocké entant que bytes32 et la valeur 
    //est un entier non signé qui socke le décompte des votes
    
    mapping(bytes32 => uint256) public votesReceived;

    //solidity ne laisse pas encore passer les tableaux de chaine de caracteres
    //nous utilisons un tableau de 32 bytes afin de stocker la liste des candidats

    bytes32[] public candidateList;

    //voici le constructeur qui va l'appeler lorsque nous deployerons notre contract
    //dans la blockchain. Quand nous deployons un contract, nous devons passer un tableau
    //qui participe à l'election 

    constructor(bytes32[] memory candidateNames) public {
        candidateList = candidateNames;
    }

    //cette fonction retourne le total des votes reçu par chaque candidats
    function totalVotesFor(bytes32 candidate) view public returns(uint256){
        require(validCandidate(candidate));
        return votesReceived[candidate];
    }

    //cette fonction incremente le compte des voies pour chaque candidats
    //c'est le décompte des voies
    function voteForCandidate(bytes32 candidate) public {
        require(validCandidate(candidate));
        votesReceived[candidate] += 1 ;
    }

    function validCandidate(bytes32 candidate) view public returns(bool) {
        for(uint i = 0; i < candidateList.length; i++){
            if(candidateList[i] == candidate){
                return true;
            }
        }
        return false;
    }
}