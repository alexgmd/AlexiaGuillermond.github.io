pragma solidity ^0.4.0;

/// @title Fidelity Points System - Solidity Smart-contract
/// @author Alexia Guillermond & Sajirami Selvaratnam

contract Fidelity{
    
    struct Client{
        address id;
        uint points;
        address sponsor;
    }
    
    struct Product{
        bytes32 name;
        uint rewardPoints;
    }
    
    address public chairperson; //actor who defines level of reward
    Client[] clients;
    Product[]products;

    // @notice: add a new account
    // @param: address of the client who sponsored the new client
    //         (default: if no sponsor then sponsor = address(0))
    function addClient(address sponsorClient){
        for(uint i = 0; i < clients.length ; i++)
        {
            if(msg.sender != clients[i].id){ 
                clients.push( Client({
                    id : msg.sender , 
                    points: 0, 
                    sponsor : sponsorClient
                }));
            }
            else{
                throw;
            }
        }
    }
    
    // @notice: sponsors a new client by a registered client and return a boolean if operation is successful
    // @param: address of this new client
    // A sponsorship gives 20 points for each actor
    function toSponsor(address newClient) returns(bool){
        uint sponsor_id;
        for(uint i = 0;i<clients.length;i++){
            if(clients[i].id==msg.sender){
                sponsor_id = i;
            }
            
            if(clients[i].id==newClient && clients[i].sponsor == address(0)){
                clients[i].sponsor = msg.sender;
                clients[i].points +=20;
                clients[sponsor_id].points += 20;
                return true;
            }
            else{
                return false;
            }
        }
    }
    
    // @notice: get a product and its associated points then add them to client's points
    // @param: product name
    function getProduct(bytes32 productName){
        for(uint i = 0;i<clients.length;i++){
            for(uint j = 0;j<products.length;j++){
                if(clients[i].id == msg.sender && products[j].name == productName){
                    clients[i].points += products[j].rewardPoints;
                }
            }
        }
    }
    
    // @notice: see if you are elligible for a reward depending on the number of points and levels
    // @param: points of client
    function getReward(uint pointsClient) returns(bytes32){
        //...
    }
    
	
}