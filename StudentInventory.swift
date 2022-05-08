//
// Main.swift
//
// Created by Ina Tolo
// Created on 2022-5-5
// Version 1.0
// Copyright (c) 2022 Ina Tolo. All rights reserved.
//
// The StudentInventory program implements an application
// that gets input from the user, stores it in an object,
// then uses a separate class to properly print it.

import Foundation

class Student {
    // properties
    var firstName: String
    var midInit: String
    var lastName: String
    var grade: Int
    var iep: Bool

    // default constructor that mimics ADT
    init (firstName: String, midInit: String, lastName: String, grade: Int, iep: Bool) {
        // referncing objects passed in
        self.firstName = firstName
        self.midInit = midInit
        self.lastName = lastName
        self.grade = grade
        self.iep = iep
    }

    // formats and displays the student info
    func printFormat() {
        print()
        print("First name: \(firstName)")
        print("Middle initial: \(midInit).")
        print("Last name: \(lastName)")
        print("Grade: \(grade)")
        print("IEP: \(iep)")
    }
}

class Subject {
    // properties
    var bestSubject: String
    var worstSubject: String

    // default constructor that mimics ADT
    init(bestSubject: String, worstSubject: String) {
        // referncing objected passed in
        self.bestSubject = bestSubject
        self.worstSubject = worstSubject
    }

    // formats and displays the subject history of student
    func printFormat() {
        print("Best subject: \(bestSubject)")
        print("Worst subject: \(worstSubject)")
    }
}

// stores exception at runtime
enum MyError: Error {
    case runtimeError(String)
}

// function that throws exception
func catchString() throws {
    throw MyError.runtimeError("Not a valid option.\n")
}

// declaring variables
var newStudentCheckLow: String = ""
var newStudentCheckUp: String = ""
var studentNumString: String = ""
var studentGradeString: String = ""
var studentIepString: String = ""
var studentIepStringLow: String = ""
var firstName: String = ""
var middleInitial: String = ""
var lastName: String = ""
var bestSubject: String = ""
var worstSubject: String = ""
var studentGrade: Int = 0
var studentIep: Bool = false
var listOfStudents: [Student] = []
var listofSubjectHistory: [Subject] = []
var studentNum: Int = -1
var elementNum: Int = 0
let error = "Not a valid option.\n"

// create a new student
var aStudent = Student(firstName: firstName,
    midInit: middleInitial, lastName: lastName,
    grade: studentGrade, iep: studentIep)
// create a new subject history
var aSubject = Subject(bestSubject: bestSubject, worstSubject: worstSubject)

while newStudentCheckUp != "Y" || newStudentCheckUp != "N" {
    // asks user if they want to enter new student
    print("Do you want to enter a student (Y/N)?: ", terminator: "")
    newStudentCheckLow = readLine()!

    newStudentCheckUp = newStudentCheckLow.uppercased()

    // checks if user wants to add a student
    if newStudentCheckUp == "Y" {
        while studentNum < 0 {
            print("How many students would you like to enter?: ", terminator: "")
            studentNumString = readLine()!

            // checks if user input can be converted to an int
            do {
                studentNum = Int(studentNumString) ?? -1234567890

                // checks if user input can be converted to an int
                if  studentNum != Int(studentNumString) {
                    try catchString()
                }

                // checks for negative input
                if studentNum < 0 {
                    print(error)
                    continue
                }

                while elementNum != studentNum {
                    print()
                    // gets users information
                    print("Enter the first name: ", terminator: "")
                    firstName = readLine()!

                    print("Enter the middle initial: ", terminator: "")
                    middleInitial = readLine()!

                    print("Enter the last name: ", terminator: "")
                    lastName = readLine()!

                    while studentGrade < 1 || studentGrade > 12 {
                        print("Enter the grade: ", terminator: "")
                        studentGradeString = readLine()!

                        do {
                            studentGrade = Int(studentGradeString) ?? -1234567890

                            // checks if user input can be converted to an int
                            if studentGrade != Int(studentGradeString) {
                                try catchString()
                            }

                            // checks if student grade is within valid range
                            if studentGrade < 1 || studentGrade > 12 {
                                print(error)
                                continue
                            } else {
                                break
                            }
                        } catch MyError.runtimeError(let errorMessage) {
                            print(errorMessage)
                        }
                    }

                    while studentIepStringLow != "true"
                        || studentIepStringLow != "false" {
                        // gets input for IEP status
                        print("Enter the IEP status (true/false): ", terminator: "")
                        studentIepString = readLine()!

                        studentIepStringLow = studentIepString.lowercased()

                        // checks if input can be accepted, the converts to boolean value
                        if studentIepStringLow == "true"
                            || studentIepStringLow == "false" {
                            studentIep = Bool(studentIepStringLow) ?? true
                            break
                        } else {
                            print(error)
                            continue
                        }
                    }

                    // gets input about best and worst subjects
                    print("Enter the student's best subject: ", terminator: "")
                    bestSubject = readLine()!

                    print("Enter the student's worst subject: ", terminator: "")
                    worstSubject = readLine()!

                    aStudent = Student(firstName: firstName,
                        midInit: middleInitial, lastName: lastName,
                        grade: studentGrade, iep: studentIep)
                    aSubject = Subject(bestSubject: bestSubject,
                        worstSubject: worstSubject)

                    // adds student and subject objects to appropriate arrays
                    listOfStudents.append(aStudent)
                    listofSubjectHistory.append(aSubject)

                    // resets student grade
                    studentGrade = -1

                    // increments counter
                    elementNum += 1
                }
                let stuLength: Int = listOfStudents.count

                print("\n------------------------------------------------\n")
                print("There are \(stuLength) students in the student list.")
                print("The students are:")

                // calls function to print information
                for loopCounter in 0..<listOfStudents.count {
                    listOfStudents[loopCounter].printFormat()
                    listofSubjectHistory[loopCounter].printFormat()
                }
            } catch MyError.runtimeError(let errorMessage) {
                print(errorMessage)
            }
        }
        break
    } else if newStudentCheckUp == "N" {
        print("Program closed.")
        break
    } else {
        print(error)
    }
}
