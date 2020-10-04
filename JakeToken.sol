pragma solidity 0.6.6;

contract LitTokenContract {
    //State Vars
    string public name;
    string public symbol;
    uint256 public totalSupply;
    mapping(address=>uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;
    
    //Events 
    event Transfer(address owner, address recipient, uint256 amount);
    event Approval(address owner, address spender, uint256 allow);
    
    constructor(uint256 _amount) public {
        name = "JakesToken";
        symbol = "JT";
        totalSupply = _amount;
        balances[msg.sender] = _amount;
    }
    
    // Read Functions
    function balanceOf(address _owner) public view returns(uint256) {
        return balances[_owner];
    }
    
    function allowance(address _owner, address _spender) public view returns(uint256) {
        return allowances[_owner][_spender];
    }
    
    //Write Functions
    
    function transfer(address _recipient, uint256 _amount) external returns(bool) {
        require(balances[msg.sender] >= _amount);
        balances[_recipient] += _amount;
        balances[msg.sender] -= _amount;
        
        emit Transfer(msg.sender, _recipient, _amount);
            return true;
    }
    
    function approve(address _spender, uint256 _amount) external returns(bool){
        allowances[msg.sender][_spender] = _amount;
        
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }
    
    function transferFrom(address _owner, address _recipient, uint256 _amount) external returns(bool) {
        require(allowances[_owner][msg.sender] >= _amount);
        balances[_owner] -= _amount;
        balances[_recipient] += _amount;
        allowances[_owner][msg.sender] -= _amount;
        
        emit Transfer(_owner, _recipient, _amount);
        return true;
    }
}