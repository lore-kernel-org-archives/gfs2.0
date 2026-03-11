Received: from omggw0005.mail.otm.yahoo.co.jp (omggw0005.mail.otm.yahoo.co.jp [182.22.18.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E53C343F
	for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.22.18.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224824; cv=none; b=Njis2A9j5lvgGXmXCPLVb2geLIVt4FJB1rBLS8nuUmGIUFZvRNqcXmdoP5SZUsoeqXsoH7BvCHnqbHr3bxoEqwzeRBZldHCOc5vMuur17rV+zUiH6F8dBeuxAx01h3wT1/gtjx7ODyteXnjjk/aZDVoJMrjex/cPrXBXNApoikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224824; c=relaxed/simple;
	bh=xcwdFd4GEKWYeJokBzyhkElkHpXGmE2GwKcP34s1M1M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GuPDQvXc5PveU7gPArbzX+pLijWTLGTq5Yez5Rr/JZTYFiD5qCV2+Y3PDh7aXWLwbiObwDeYj7WGxgrzqw4DjvbSq5eDpRh5NH7e1Ny/8XNVIJt7E7N9XhtaquDrkdT+GLFNFVGeVaTbRPsjq2rxZtluD3VM0H7L6peJNoQacas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ymail.ne.jp; spf=pass smtp.mailfrom=ymail.ne.jp; dkim=pass (2048-bit key) header.d=ymail.ne.jp header.i=@ymail.ne.jp header.b=TLEQqlM1; arc=none smtp.client-ip=182.22.18.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ymail.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ymail.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ymail.ne.jp header.i=@ymail.ne.jp header.b="TLEQqlM1"
X-YMail-OSG: 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
X-Sonic-MF: can-yildirim@ymail.ne.jp
Received: from sonicgw.mail.gze.yahoo.co.jp by sonicconh6101.mail.ssk.ynwp.yahoo.co.jp with HTTP; Wed, 11 Mar 2026 10:26:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773224814;
	s=ymailnejp-202506; d=ymail.ne.jp;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:Reply-To:From:Date;
	bh=FCEMlkiViMYwvdBL81yLN9K7wklt3+CFuNweRQEzQPA=;
	b=TLEQqlM1A17R8fSaduMuW3nwIcHc0shVOJChSK+OC7EAmiZ2YsE8HFLfNb0jZY6v
	bE0T0FmWjgBcBZoHo3DEPxXjEAj71+oruOvQPfNxldXGVfygo7s/WBXqF4TXDsPJ1Un
	RPxWILLiaHn+DAhL8XUsjQclnRMTFXYFDe4p5lAKQCt0ZSN2iD7fJV8PbnRB2wNhMaV
	X0cDs2H/YbGzQU1sfdgqvIQwclUD8R+MGMdJjT3uUCTtSwCawhRGB3Jew2gv2oAS6Dw
	teGdJrkJst7bHSeeEFUZOWKAz+QhXHbrSxCVNYMgXfL4WgVIppHnWCoaFml61sxPCAx
	sgq3xmIqjQ==
Date: Wed, 11 Mar 2026 19:26:54 +0900 (JST)
From: can-yildirim@ymail.ne.jp
Reply-To: can-yildirim@ymail.ne.jp
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "security@kernel.org" <security@kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"aahringo@redhat.com" <aahringo@redhat.com>,
	"teigland@redhat.com" <teigland@redhat.com>
Message-ID: <752863286.16555.1773224814491@mail.yahoo.co.jp>
In-Reply-To: <2026031118-shower-darkened-3e3a@gregkh>
References: <173757593.643632.1773164229041.ref@mail.yahoo.co.jp> <173757593.643632.1773164229041@mail.yahoo.co.jp> <2098115699.650906.1773192682434@mail.yahoo.co.jp> <2026031118-shower-darkened-3e3a@gregkh>
Subject: Re: Re: [vs] DLM debugfs information disclosure via
 non-null-terminated resource name
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey Greg,
Nice to meet you...
> =E6=97=A5=E6=99=82=EF=BC=9A2026/03/11 =E6=B0=B4 15:42
> =E4=BB=B6=E5=90=8D=EF=BC=9ARe: [vs] DLM debugfs information disclosure vi=
a non-null-terminated resource name
>=20
>=20
> On Wed, Mar 11, 2026 at 10:31:22AM +0900, can-yildirim@ymail.ne.jp wrote:
> > Dear maintainers,
> > There is an possible information disclosure vulnerability in the DLM
> > subsystem's debugfs interface.
>=20
> debugfs is, by default, only readable by root, and contains loads of
> stuff like this, as it's full of debug information on the system.  So
> much so that many systems do not enable it in their kernels, and others
> do not mount it at all.  So it's not really a problem overall from a
> security point of view.
>=20
> > The issue resides in the function
> > print_format2_lock() in fs/dlm/debug_fs.c. When a resource name
> > is exactly DLM_RESNAME_MAXLEN bytes long and contains no null
> > byte, the %s format specifier in a seq_printf call reads beyond
> > the intended buffer, exposing adjacent kernel memory.
>=20
> That's not good, can you just send a patch for this to the developers
> and mailing list and they can apply it like normal?
>=20
> thanks,
>=20
> greg k-h
>=20
While debugfs is indeed root-only and often disabled, this vulnerability sp=
ecifically targets environments that do enable it and cannot migrate to use=
rspace coordination systems like ZooKeeper or Redis due to resource constra=
ints or legacy requirements. In those clustered environments (e.g., HPC, Pa=
cemaker/DRBD setups), DLM is actively used, debugfs is present, and local r=
oot access can be chained with this leak to bypass KASLR and facilitate fur=
ther exploitation. So while the overall risk is low, the impact in the spec=
ific niche where this code actually runs is real.
On top of this, I would also suggest you looking at things i can`t even spe=
ll it`s name right once; IBM s390x architectures like(IBM Z/LinuxONE). Thes=
e systems cost like hundreds of thousands to $15M+, and they power the worl=
d basically[Not an IBM advertisement btw, just some sprinkles].=20
On these platforms, stability and backward compatibility is nirvana dude,an=
d you can't just "rewrite everything to use ZooKeeper". or build your own p=
rogram[Was it chubby?chobby?chobani maybe idk] like Google did because they=
 can. The kernel DLM is on the environments built and relied upon, debugfs =
is often present. A KASLR bypass on these systems isn't just an academic ex=
ercise... It's a real domino step towards to an infrastructure that literal=
ly cannot afford downtime, but still, some device like this somewhere in th=
e world probably depends more or less on what you're currently probably lau=
ghing at, anyways...
So in short while this may seem like "just another debugfs something someth=
ing something" from a desktop Linux perspective, the impact profile changes=
 dramatically when you consider where this code actually runs in production=
.
Also, i am not going to write or commit an patch, i wrote somethings about =
that but decision to commit/implement is something i don`t care at the mome=
nt.

Thanks,
Fatih Can Yildirim

> Dear maintainers,
> There is an possible information disclosure vulnerability in the DLM
> subsystem's debugfs interface. The issue resides in the function
> print_format2_lock() in fs/dlm/debug_fs.c. When a resource name
> is exactly DLM_RESNAME_MAXLEN bytes long and contains no null
> byte, the %s format specifier in a seq_printf call reads beyond
> the intended buffer, exposing adjacent kernel memory.
> Description:
> When printing lock information in format 2, the code does:
> seq_printf(s, "... "%s"\n", r->res_name);
> The res_name field is a fixed-size byte array of length
> r->res_length (bounded by DLM_RESNAME_MAXLEN) and is not
> guaranteed to be null-terminated. If an attacker creates a resource
> with a name of maximum length consisting entirely of non-null bytes
> (e.g., 64 'A's), the %s formatter will continue reading past the
> end of the res_name buffer until it encounters a null byte in
> kernel memory. This leaks the contents of the following memory,
> which may include kernel pointers, slab metadata, or other sensitive
> data.
> Impact:
> Local attacker on a system where
> DLM is used (e.g., clustered servers running GFS2/OCFS2 with
> dlm_controld) can read kernel memory beyond the resource name.
> This defeats KASLR, reveals heap layout, and may expose credentials
> or other secrets. The leak is a classic information disclosure that
> can be used as a building block for further privilege escalation.
> Initially;
> Create a DLM lockspace (e.g., via dlm_tool join test_ls).
> Acquire a lock on a resource with a 64-byte name of non-null
> bytes (e.g., 64 'A's) using dlm_ls_lock_wait.
> Read /sys/kernel/debug/dlm/test_ls/locks (format 2).
> Observe the 64 'A's followed by disclosed kernel memory.
> Proposed fix:
> Perhaps replacing the unbounded %s with a bounded %.*s using the known
> resource length.
> Side_Note: The exact line numbers
> may vary. Thinking of an usage like; %.*s with r->res_length to
> limit the output to the actual name length. Proper tabs should be
> used though.
>=20
> CVE request:
> Please assign a CVE ID for this vulnerability if applicable.
> =20
> Thank you for your attention. Please let me know if you need any
> further information.
> Best regards,
> Fatih Can Yildirim=20
>=20
>=20


> ----- =E5=BC=95=E7=94=A8=E5=85=83=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=
=82=B8 -----
>=20
> From=EF=BC=9A"Greg KH" <gregkh@linuxfoundation.org>
> To=EF=BC=9A"can-yildirim@ymail.ne.jp" <can-yildirim@ymail.ne.jp>
> Cc=EF=BC=9A"security@kernel.org" <security@kernel.org>; "gfs2@lists.linux=
.dev" <gfs2@lists.linux.dev>; "aahringo@redhat.com" <aahringo@redhat.com>; =
"teigland@redhat.com" <teigland@redhat.com>
> =E6=97=A5=E6=99=82=EF=BC=9A2026/03/11 =E6=B0=B4 15:42
> =E4=BB=B6=E5=90=8D=EF=BC=9ARe: [vs] DLM debugfs information disclosure vi=
a non-null-terminated resource name
>=20
>=20
> On Wed, Mar 11, 2026 at 10:31:22AM +0900, can-yildirim@ymail.ne.jp wrote:
> > Dear maintainers,
> > There is an possible information disclosure vulnerability in the DLM
> > subsystem's debugfs interface.
>=20
> debugfs is, by default, only readable by root, and contains loads of
> stuff like this, as it's full of debug information on the system.  So
> much so that many systems do not enable it in their kernels, and others
> do not mount it at all.  So it's not really a problem overall from a
> security point of view.
>=20
> > The issue resides in the function
> > print_format2_lock() in fs/dlm/debug_fs.c. When a resource name
> > is exactly DLM_RESNAME_MAXLEN bytes long and contains no null
> > byte, the %s format specifier in a seq_printf call reads beyond
> > the intended buffer, exposing adjacent kernel memory.
>=20
> That's not good, can you just send a patch for this to the developers
> and mailing list and they can apply it like normal?
>=20
> thanks,
>=20
> greg k-h
>=20

