"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib

class TestLoginUser(testLib.RestTestCase):
    
    def assertResponse(self, respData, count=1, errCode = testLib.RestTestCase.SUCCESS):
        expected = { 'errCode': errCode}
        if count is not None:
            expected['count']=count
        self.assertDictEqual(expected, respData)

    def testLogin1(self):
        self.makeRequest("/users/add", method="POST", data ={'user':'user1', 'password': 'password'})
        respData = self.makeRequest("/users/login", method="POST", data={'user':'user1', 'password':'password'})
        self.assertResponse(respData, count = 2)

    def testLogin2(self):
        self.makeRequest("/users/add", method="POST", data ={'user':'user1', 'password': 'password'})
        respData = self.makeRequest("/users/login", method="POST", data={'user':'user1', 'password':'wrong'})
        self.assertResponse(respData, count = None, errCode=testLib.RestTestCase.ERR_BAD_CREDENTIALS)

    def testLogin3(self):
        self.makeRequest("/users/add", method="POST", data ={'user':'user1', 'password': 'password'})
        self.makeRequest("/users/add", method="POST", data ={'user':'user2', 'password': 'password'})
        self.makeRequest("/users/login", method="POST", data={'user':'user1', 'password':'wrong'})
        respData = self.makeRequest("/users/login", method="POST", data={'user':'user1', 'password':'password'})
        self.assertResponse(respData, count = 2)

        

class TestAddUser(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
            Check that the response data dictionary matches the expected values
            """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)
    
    def testAdd1(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 1)

    def testAdd2(self):
        respData = self.makeRequest("/users/add", method="POST", data = {'user':'','password':'password'})
        self.assertResponse(respData, count = None, errCode=testLib.RestTestCase.ERR_BAD_USERNAME)

    def testAdd3(self):
        self.makeRequest("/users/add", method="POST", data = {'user':'ryan','password':'password'})
        respData = self.makeRequest("/users/add", method="POST", data = {'user':'ryan','password':'password'})
        self.assertResponse(respData, count = None, errCode=testLib.RestTestCase.ERR_USER_EXISTS)

    def testAdd4(self):
        pw = 'password'*128
        respData = self.makeRequest("/users/add", method="POST", data = {'user':'ryan','password':pw})
        self.assertResponse(respData, count =None, errCode=testLib.RestTestCase.ERR_BAD_PASSWORD)
    
