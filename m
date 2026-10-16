Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A347A89E
	for <gfs2@lists.linux.dev>; Fri, 16 Oct 2026 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151726; cv=none; b=bahHn8gtRQZ14cPYFubFPobYQLBPHTs1A7Sh5ZgO/2OaT3H8Jvm0AViNLyEDODk70uCYoQWlMNv9zVjgxLLcP27Ujm3QqFwbDup/ZEoE8YSr9OXDsnxK7XZ4amsY0qk1BtjmFm+mYbe1Kfz6cyXLfuoKxF2tAMRdM4M+Y+PbX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151726; c=relaxed/simple;
	bh=ezoQ4WUgreOHbTRC4nKnZTKsxVVkS+YyDvzMvR6XNGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNoihGq1Vswfd7y+anh+yKL92OdxRjYkSjgUFD6XyNzDKzvTMtzpA1Zw8LeALdBpAt1i86ue6XnfpUe3ACWySVQ6Laa8UT9g/RiWZLzvd1Ck9ltHVGnIFAxePd/eLZPN5iNJcFV8w8/31lcDvhL1ai4cJXbKC+6lpJhKmSQSZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bK8UA+ak; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bK8UA+ak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792151709; x=1792756509; i=markus.elfring@web.de;
	bh=ezoQ4WUgreOHbTRC4nKnZTKsxVVkS+YyDvzMvR6XNGM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bK8UA+akKWeV2HAswtTie3mVBHQ3uYSupQPwPMwBe2py5+G+0wnyokSl3fZxu4Od
	 MdcSMlALrKVaeP+rX10+MwFN+g08exWQR+HQRfYjIBBcjM4FUGmbHDo3zfmSzWYvT
	 nyFOHnsdN/BA0jUnsEVfV+4Oyos/E5kmE4adymL0PY5LhEgr97XJXiS/JLbvms2JC
	 7OZqx++aG6q8ubQo65yEWQzZwiHkk4lg3HRinp4ZRR7qVbn+dyHGei5DL34hZH3xL
	 BCtHX7F9kuEEYC2cQk9okN03mdLiEjiykkpm3qBK3nA39BP6AcmAWrPgTvrcoCpMj
	 qHC7oPSNWI2XMXsFdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ma0Tg-1x5fzN1F5A-00KSGz; Fri, 16
 Oct 2026 13:55:09 +0200
Message-ID: <018e2f9f-1052-4d80-8499-c24f28e9f779@web.de>
Date: Fri, 16 Oct 2026 13:55:07 +0200
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dlm: clean up a type in waiters_read()
To: Dan Carpenter <error27@gmail.com>, Alexander Aring <aahringo@redhat.com>,
 gfs2@lists.linux.dev, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, David Teigland <teigland@redhat.com>
References: <ar4BZ26gjQEjZgIa@stanley.mountain>
 <ffeb3e5b-d9de-4337-b250-e27667024461@web.de>
 <CAK-6q+heOWNY8CY8dgotxzEeFC_-huHnnO2pgH8kJsJSGryOtw@mail.gmail.com>
 <c8b6843c-c87a-4330-b6f4-e556117a8026@web.de>
 <atHq_LLtPx8SXMUt@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <atHq_LLtPx8SXMUt@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LI0cml2PKVN7lJhQKouWpMCyaU8ZLXry/f/1EvptSxPq0TQaoIH
 0p/FVWQZupu5qh/z18sV2vP64AXEdm0/obIe7fgx4amc313M0KsmEWrhygEL9G4ULPAzulv
 RQE0ais+yi4caGFMpemnw0wQ0DdL+rqu/jmN0tVZ9LyF9dha8s3zhISnh+iGwhHWe3JFY0E
 tslufgGuIEfCmKkmjOZZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pUjkxkcB0qk=;JS9NOWj0KHy9bwYcrqOc3KSo381
 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

>> Can the usage of a data type like =E2=80=9Cint=E2=80=9D become more des=
irable for =E2=80=9Cret=E2=80=9D
>> according to the affected function implementation?
>=20
> Either way is a defensible style choice for "ret" so I left it as-is.
Will consistent data type specifications be preferred in subsequent softwa=
re revisions?

Regards,
Markus
