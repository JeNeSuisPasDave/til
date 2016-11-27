# How to grant a unit tests access to internal types

In C# you can restrict types and members to be accessible only from code within that same assembly by using the access modifier "internal". That is a _best practice_, but it has one downside&emdash;you cannot access those types and members in the unit test assemblies that need to test that _internal_ code.

However, there is a way of granting specific assemblies access to the internal types and members. You do so by adding some attributes to the target assembly's AssemblyInfo.cs file. Doing so requires:

* the unit test assembly be signed
* the public signing key be converted to an ASCII string

## Getting the public key as an ASCII string

This command will extra the public key from the signing key (of the unit test assembly) and store it as a binary blob in a new file. In this example, the signing key file is `SigningKey.snk` and the public key is extracted to `PublicKey.dat`:

```powershell
sn -p SigningKey.snk PublicKey.dat
```

This command will display the ASCII string equivalent of the public key from `PublicKey.dat`:

```powershell
sn -tp PublicKey.dat
```

For example:

```nohighlight
> sn -p SigningKey.snk x.dat

Microsoft (R) .NET Framework Strong Name Utility  Version 4.0.30319.33440
Copyright (c) Microsoft Corporation.  All rights reserved.

Public key written to x.dat

> sn -tp x.dat

Microsoft (R) .NET Framework Strong Name Utility  Version 4.0.30319.33440
Copyright (c) Microsoft Corporation.  All rights reserved.

Public key (hash algorithm: sha1):
0024000004800000940000000602000000240000525341310004000001000100db9f7ebb7dd7b5
7bdaf8640fe95fa3a45c30a188b11a919e73046b8fa8885b5bb5ed941fd4b9e6d108f1ee50d5e0
73cae6e7dcbba289d8f45280a8105e6951b04d7f67846f582d24b3e9f6344529df4fa28d9cd088
ece769a780453a52f761d2a2a3f55adc89c0307e555ac4f32ac50710d7f94b425ac65f95aaa280
849924ec

Public key token is f7f809258242ed9b

```

## Adding the InternalsVisibleTo attribute to the AssemblyInfo.cs file

Open the target DLLs `AssemblyInfo.cs` file. This file belongs to the project with the _internal_ types and members. Add an `InternalsVisibleTo` attribute, specifying the name of the unit test DLL and it's public key.

For example, to give the unit test assembly `Test.BusinessLogic.dll` access to the `internal` types and members of another assembly, the assembly being tested, this is added to the `AssemblyInfo.cs` file of that other assembly:

```csharp
[assembly: InternalsVisibleTo(
	"Test.BusinessLogic, PublicKey=0024000004800000940000000602000000240000525341310004000001000100db9f7ebb7dd7b57bdaf8640fe95fa3a45c30a188b11a919e73046b8fa8885b5bb5ed941fd4b9e6d108f1ee50d5e073cae6e7dcbba289d8f45280a8105e6951b04d7f67846f582d24b3e9f6344529df4fa28d9cd088ece769a780453a52f761d2a2a3f55adc89c0307e555ac4f32ac50710d7f94b425ac65f95aaa280849924ec")]
```

You can give access to additional assemblies by adding additional `InteralsVisiblTo` attributes.

_**Note:**_ This is one of the places I found this solution: [http://weblogs.asp.net/bhouse/using-internalsvisibleto-attribute-with-strong-named-assemblies](http://weblogs.asp.net/bhouse/using-internalsvisibleto-attribute-with-strong-named-assemblies)

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
