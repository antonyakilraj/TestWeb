<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.util.Hashtable" import="javax.naming.Context"
		import="javax.naming.NamingEnumeration"
		import="javax.naming.NamingException"
		import="javax.naming.directory.DirContext"
		import="javax.naming.directory.InitialDirContext"
		import="javax.naming.directory.SearchControls"
		import="javax.naming.directory.SearchResult"
		import="javax.naming.directory.Attribute"
		%>

	<table border="2">
		<tr>
			<th>UID</th>
			<th>NAME</th>
		</tr>

		<%
		String s = request.getParameter("value");
		out.println("The value entered is:" + s);
		out.println("<br/>");

		try {

			DirContext ldapContext;

			Hashtable<String, String> ldapEnv = new Hashtable<String, String>(11);
			ldapEnv.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
			ldapEnv.put(Context.PROVIDER_URL, "ldap://localhost:389");
			ldapEnv.put(Context.SECURITY_AUTHENTICATION, "simple");
			ldapEnv.put(Context.SECURITY_PRINCIPAL, "cn=Directory Manager");
			ldapEnv.put(Context.SECURITY_CREDENTIALS, "Capgemini#123");
			ldapContext = new InitialDirContext(ldapEnv);

			SearchControls searchCtls = new SearchControls();
			
			String returnedAtts[]={"uid","cn"};
		      searchCtls.setReturningAttributes(returnedAtts);
			
			searchCtls.setSearchScope(SearchControls.SUBTREE_SCOPE);

			String searchFilter = "(&(objectClass=inetOrgPerson)(uid=" + s + "))";
			String searchBase = "dc=example,dc=com";

			NamingEnumeration<SearchResult> answer = ldapContext.search(searchBase, searchFilter, searchCtls);

			while (answer.hasMoreElements()) {

				SearchResult sr = (SearchResult) answer.next();

				javax.naming.directory.Attributes attrs = sr.getAttributes();
				Attribute uid = attrs.get("uid");
				Attribute name = attrs.get("cn");
			
				String struid=uid.get().toString();
				String strname=name.get().toString();
				
			%>	
				<tr>
			    <td><%=struid %></td>
			    <td><%=strname %></td>
			</tr>
			
			<%
			
			}
			ldapContext.close();

		}

		catch (Exception e) {
			System.out.println(" Search error: " + e);
			e.printStackTrace();
			System.exit(-1);
		}
	%>
	</table>
</body>
</html>