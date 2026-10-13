Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D252FE2B
	for <gfs2@lists.linux.dev>; Tue, 13 Oct 2026 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905250; cv=none; b=X16DBv4R5/usrjydELqaq1MiPMw9e/0QTF3eV5ARX/89x3tIfrqWZd+ARHWOOOkiGYEtdCNJzmKs1jYdOEVK6nFhLWwIuJO9Po1GS9FR4AxbJyufZMzG+Imhy+gSXelG944juq2cRN71IlUFk1cKx2gvMexiqQH11nq9tJlrj98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905250; c=relaxed/simple;
	bh=/RKufF2yTI2+zp13mICGLhL+5e108L+GMt4MQqF+f6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1K3SFT7vDHHzehUDQcVFJtg0Pq9OZyL7M8O9QcEPW7k+ykxKwv3AiTtLibw/28s8tUM1ngmvwlZEzs3r1OS9tXJz9Wz/KXP8YyXgfQMdQ1NiKnKxyw8CNQLcenj4osfatb9s9VgA6jxboMJvLyhoawPb3NT7+3FpwJVFm9/H/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FcFmos47; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FcFmos47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791905232; x=1792510032; i=markus.elfring@web.de;
	bh=/RKufF2yTI2+zp13mICGLhL+5e108L+GMt4MQqF+f6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FcFmos47L0w50ikWcosD7MidFxEEA5nJtvl0iL8cAkhpuN3CbXkGWD7drO4w/6Id
	 eSor5nB5ReVmwVz1VMTE7JJ8pg3e8BXSZ3fOlbomTwM6pcaQAJ2VyM9q0s2wqn1ub
	 XK3ThM/7aa9kJ2VCTxTQj8p3dDwbaY0OPw3gUrmM6ngN4bOa6JCZhnetcRkPXyQyi
	 PBennXeJV0k57C53v65FhLz48pOWyVC2iM1wSj0ZRFvZY6F6IuaAp+19NrALVtMs9
	 mnF79DOCwD7gzYV+ffalZIX847r9dsBE9n7unYhL6XER58b5dBLYGKmRAS8Rmu3pU
	 EAkCu0MMtdrPeYHqsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1uAl-1wWozh1YQT-00uaXP; Tue, 13
 Oct 2026 17:27:12 +0200
Message-ID: <c8b6843c-c87a-4330-b6f4-e556117a8026@web.de>
Date: Tue, 13 Oct 2026 17:27:10 +0200
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dlm: clean up a type in waiters_read()
To: Alexander Aring <aahringo@redhat.com>, Dan Carpenter <error27@gmail.com>,
 gfs2@lists.linux.dev, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, David Teigland <teigland@redhat.com>
References: <ar4BZ26gjQEjZgIa@stanley.mountain>
 <ffeb3e5b-d9de-4337-b250-e27667024461@web.de>
 <CAK-6q+heOWNY8CY8dgotxzEeFC_-huHnnO2pgH8kJsJSGryOtw@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAK-6q+heOWNY8CY8dgotxzEeFC_-huHnnO2pgH8kJsJSGryOtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ianABftfhsG9rCHi3fCDgKa9fC41BS/G3w0zc4JDmco+33N2IY
 jjvEYYj2CqGCGFTelaUNxkh04zJepsPOgmJ555ik87znjvUWhrbQdK2/T4RQCwDXUOG6mUG
 kETY5IXU4sTaeBg2xL8AkQPKzzfQoqvfJltJcJhV56HdtXc6epouCgh2ZH2KhgsPAd7WrAi
 QGy2HQ7azbz5wn9eqsfMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kP5ZeCIJkf4=;aRUPQMETc4/TK+VHB4iI9bxzXom
 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
 XXSy

>>> This doesn't affect runtime but "rv" stores error codes and so
>>> declare it as ssize_t instead of size_t.
>>
>> Can a similar adjustment matter also for the local variable =E2=80=9Cre=
t=E2=80=9D?
>=20
> What do you mean by 'matter'? It's declared as cleanup.
Can the usage of a data type like =E2=80=9Cint=E2=80=9D become more desira=
ble for =E2=80=9Cret=E2=80=9D
according to the affected function implementation?

Regards,
Markus
