// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RegisterDisaster {
    address public owner;   // เก็บข้อมูลของเจ้าของ Smart Contract (ใช้ใน Constructor)
    struct Person {
        string idCard;      // รหัสบัตรประชาชน
        string firstName;   // ชื่อ
        string lastName;    // นามสกุล
        string addr;        // ที่อยู่
    }

    Person[] private people; // สร้างตัวแปรอาเรย์ของประเภท Person เพื่อเก็บข้อมูลผู้คนที่จะลงทะเบียน
    mapping(string => uint256) private idToIndex; // สร้างตัวแปรแมพเพื่อเก็บข้อมูลดัชนีของผู้คนตามรหัสบัตรประชาชน

    // constructor ตั้งค่าผู้ที่ deploy smart contract ให้เป็นเจ้าของ
    constructor() {
        owner = msg.sender;
    }

    // ฟังก์ชันสำหรับลงทะเบียนผู้เข้าร่วม
    function registerPerson(
        string memory _idCard,
        string memory _firstName,
        string memory _lastName,
        string memory _addr
    ) public {
        require(idToIndex[_idCard] == 0, "Person already registered");

        people.push(Person(_idCard, _firstName, _lastName, _addr));
        idToIndex[_idCard] = people.length; // เก็บดัชนี +1 เพราะ mapping ไม่สามารถเก็บค่าดัชนี 0 ได้
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมทั้งหมด
    function getAll() public view returns (Person[] memory) {
        return people;
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี index ที่กำหนด
    function getPerson(uint256 index) public view returns (Person memory) {
        require(index < people.length, "Index out of range");
        return people[index];
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี idCard ที่กำหนด
    function getID(string memory _idCard) public view returns (Person memory) {
        uint256 index = idToIndex[_idCard];
        require(index > 0, "Person not found"); // เนื่องจาก mapping เริ่มต้นเป็น 0
        return people[index - 1]; // ดึงข้อมูลจากอาเรย์
    }
}
