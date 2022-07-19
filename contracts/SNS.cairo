# SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import (Uint256, uint256_add)
from starkware.cairo.common.math import (assert_not_equal, assert_not_zero)
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.syscalls import get_caller_address

from openzeppelin.token.erc721.library import ERC721
from openzeppelin.introspection.ERC165 import ERC165

@storage_var
func counter () -> (count : Uint256):
end

@constructor
func constructor{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }():
    ERC721.initializer('Starkware Naming Service', 'SNS')
    counter.write(Uint256(1,0))
    return ()
end

#
# Getters
#

@view
func supportsInterface{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(interfaceId: felt) -> (success: felt):
    let (success) = ERC165.supports_interface(interfaceId)
    return (success)
end

@view
func name{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }() -> (name: felt):
    let (name) = ERC721.name()
    return (name)
end

@view
func symbol{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }() -> (symbol: felt):
    let (symbol) = ERC721.symbol()
    return (symbol)
end

@view
func balanceOf{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(owner: felt) -> (balance: Uint256):
    let (balance) = ERC721.balance_of(owner)
    return (balance)
end

@view
func ownerOf{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(token_id: Uint256) -> (owner: felt):
    let (owner) = ERC721.owner_of(token_id)
    return (owner)
end

@view
func getApproved{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(token_id: Uint256) -> (approved: felt):
    let (approved) = ERC721.get_approved(token_id)
    return (approved)
end

@view
func isApprovedForAll{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(owner: felt, operator: felt) -> (isApproved: felt):
    let (isApproved) = ERC721.is_approved_for_all(owner, operator)
    return (isApproved)
end

@view
func tokenURI{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(tokenId: Uint256) -> (tokenURI: felt):
    let (tokenURI) = ERC721.token_uri(tokenId)
    return (tokenURI)
end

#
# Externals
#

@external
func approve{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(to: felt, tokenId: Uint256):
    ERC721.approve(to, tokenId)
    return ()
end

@external
func setApprovalForAll{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(operator: felt, approved: felt):
    ERC721.set_approval_for_all(operator, approved)
    return ()
end

@external
func transferFrom{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(from_: felt, to: felt, tokenId: Uint256):
    ERC721.transfer_from(from_, to, tokenId)
    return ()
end

@external
func safeTransferFrom{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(from_: felt, to: felt, tokenId: Uint256, data_len: felt, data: felt*):
    ERC721.safe_transfer_from(from_, to, tokenId, data_len, data)
    return ()
end

@external
func _mint{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }(to: felt, token_id: Uint256):
    ERC721._mint(to, token_id)
    return ()
end

@storage_var
func link_ethAdr_to_name (adr : felt) -> (name : felt):
end

@storage_var
func link_name_to_ethAdr (name : felt) -> (ethAdr : felt):
end

@storage_var
func registry_adr_to_name (adr : felt) -> (name : felt):
end

@storage_var
func registry_name_to_adr (name : felt) -> (adr : felt):
end

@storage_var
func name_to_tokenId (name : felt) -> (tokenId : Uint256):
end

@storage_var
func tokenId_to_name (tokenId : Uint256) -> (name : felt):
end

@view
func sns_lookup_tokenId_to_name {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        tokenId : Uint256
    ) -> (
        exist : felt,
        name : felt
    ):
    alloc_locals

    let (name) = tokenId_to_name.read (tokenId)

    local exist
    if name == 0:
        assert exist = 0
    else:
        assert exist = 1
    end

    return (exist, name)
end

@view
func sns_lookup_adr_to_name {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        adr : felt
    ) -> (
        exist : felt,
        name : felt
    ):
    alloc_locals

    let (name) = registry_adr_to_name.read (adr)

    local exist
    if name == 0:
        assert exist = 0
    else:
        assert exist = 1
    end

    return (exist, name)
end

@view
func sns_lookup_name_to_adr {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        name : felt
    ) -> (
        exist : felt,
        adr : felt
    ):
    alloc_locals

    let (adr) = registry_name_to_adr.read (name)

    local exist
    if adr == 0:
        assert exist = 0
    else:
        assert exist = 1
    end

    return (exist, adr)
end

@view
func sns_lookup_name_to_ethAdr {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        name : felt
    ) -> (
        exist : felt,
        ethAdr : felt
    ):
    alloc_locals

    let (ethAdr) = link_name_to_ethAdr.read (name)

    local exist
    if ethAdr == 0:
        assert exist = 0
    else:
        assert exist = 1
    end

    return (exist, ethAdr)
end

#
# register adr -> name mapping in registry
# can only call from the address itself i.e. no delegate call allowed
#
@external
func sns_register {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
    name : felt) -> ():
    alloc_locals

    # TODO: check if name is a string literal i.e. valid ascii encoding

    let (adr) = get_caller_address ()

    #
    # Revert if the given name has already been registered with an address in the registry
    # (zero address is not valid)
    # this function reverts also if caller address tries to re-register with the same name
    #
    let (adr_check) = registry_name_to_adr.read (name)
    assert adr_check = 0

    let (count) = counter.read()

    # Register adr <=> name
    registry_adr_to_name.write (adr, name)
    registry_name_to_adr.write (name, adr)
    name_to_tokenId.write (name, count)
    tokenId_to_name.write (count, name)

    _mint(adr, count)

    let (newCount, _) = uint256_add(count, Uint256(1,0))
    counter.write(newCount)

    return()
end

@external
func sns_link_ethAdr_to_name {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
    ethAdr: felt,
    name : felt) -> ():
    alloc_locals

    link_ethAdr_to_name.write (ethAdr,name)
    link_name_to_ethAdr.write (name,ethAdr)

    return()
end