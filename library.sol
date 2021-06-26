// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BookLibrary{
    
    struct Book{
        string bookName;
        uint8 bookNumber;
        bool exist;
    }
    
    struct Member{
        string memberName;
        uint memberNumber;
        address memberAddress;
        bool lent;
        bool memberShip;
        uint8 bookNumber;
    }
    
    address chairPerson;
    
    mapping(uint=>Book)Books;
    mapping(address=>Member)Members;
    
    constructor()public{
      chairPerson=msg.sender;
      Book memory b1=Book("Riazi",1,true);
      Books[0]=b1;
      Book memory b2=Book("Farsi",2,true);
      Books[1]=b2;
      Book memory b3=Book("Zaban",3,true);
      Books[2]=b3;
        }
     modifier onlyChairperson(address _add){
         require(_add==chairPerson);
         _;
     }
        
    function register(address _memberAddress) public onlyChairperson(msg.sender) {
     
     Members[_memberAddress].memberShip=true;
    }
    
    modifier validMemberShip(address _add){
      require(Members[_add].memberShip==true);
      _;
    }
    
    modifier validMember(address _add){
      require(Members[_add].lent==false);  
    _;
        
    }
    modifier validBook(uint8 _bookNumber){
     require(Books[_bookNumber].exist==true);
     _;   
    }
    function leding(address _memberAddress, uint8 _bookNumber)public validMemberShip(_memberAddress) validMember(_memberAddress) validBook(_bookNumber) {
          Members[_memberAddress].lent=true;
           Members[_memberAddress].bookNumber=_bookNumber;
           Books[_bookNumber].exist=false;
           
    }
    
    function giveBack(address _memberAddress, uint8 _bookNumber)public validMemberShip(_memberAddress) {
         Members[_memberAddress].lent=false;
          Members[_memberAddress].bookNumber=0;
          Books[_bookNumber].exist=true;
          
    }
    
    function showBook(address _memberAddress)public validMemberShip(_memberAddress) view returns (string memory _bookName){
        
        uint8 i=Members[_memberAddress].bookNumber;
        _bookName=Books[i].bookName;
    }
    
}
