
# Who JB 602-501-7702  
# What AD report of users membership 
# When manual
# Why to help track users
# Tested , run as admin, from ISE, no raw PS yet. 
################################################


import-module ActiveDirectory

$Collection = @()
$obj = New-Object PsObject

# basic user reporting
#$OU="CN=Users,DC=foobar,DC=com"
$OU="DC=foobar,DC=com"

$result=(Get-ADUser  -Properties * -Filter * -SearchBase $OU)

$result | foreach-object {

# extract user details 

$SamAccountName=$_.SamAccountName
$DistinguishedName=$_.DistinguishedName
$UserPrincipalName=$_.UserPrincipalName

$f="SamAccountName";$obj | Add-Member -Force -MemberType NoteProperty "$f" -value $($SamAccountName)
$f="DistinguishedName";$obj | Add-Member -Force -MemberType NoteProperty "$f" -value $($DistinguishedName)
$f="UserPrincipalName";$obj | Add-Member -Force -MemberType NoteProperty "$f" -value $($UserPrincipalName)

# We have the user name now
# pull the group membership details.
$resultgroup=(Get-ADPrincipalGroupMembership $SamAccountName) 
$boo=[string]$resultgroup.name
$obj | add-member -force -membertype NoteProperty "Group" -Value $($boo) 

 
# save the template syntax 
# $f="";$obj | Add-Member -Force -MemberType NoteProperty "$f" -value $($)
 
 
 # ok each
 $Collection += $obj

 # obj is sort of temp var, reset after save the data to collection 
 $obj = New-Object PsObject
 }

# collection to disk 
$Collection |Export-Csv -NoTypeInformation -Delimiter ';' -Path AD.User.Groups.$(get-date -format ddMMyyyy).csv

# ende 


