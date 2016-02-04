<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Case_Email2Case</fullName>
        <description>isEmail to Case filed is checked</description>
        <field>isEmail_to_Case__c</field>
        <literalValue>1</literalValue>
        <name>Case Email2Case</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Case Email2Case</fullName>
        <actions>
            <name>Case_Email2Case</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Email</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Email 2 Case origin Email</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
