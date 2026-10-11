Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFF424D6E
	for <gfs2@lists.linux.dev>; Sun, 11 Oct 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791720697; cv=none; b=B9+OCcPcnNQplQhvBh7hikFVc2cocxgHwQq5C7eO04w9flEPiMVf7XL/5FNpAztj6e+8Xkk4jrQxsQpCjHd8U5/QCKyL+y100L9pEkpk3LEHlujShlkpugMjNtRx1u0RUFYGPu2mhlxJN7Odwk2kdT/AH1bxHO4oxOw7yi3s47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791720697; c=relaxed/simple;
	bh=97ys9gRqrEZ8QWJSZ5qvUMjJJLvd3tNrB4aJIYBAGhk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=a/xaDQS4u+A5ldwuRkuyVyyF5Wmkc42T4TmrwHiMDBVaf9mkwGAU0wxUpDcyWQGe3FJv3J41Y7P1oQKRpxAeEjUtif4Z1pXZJAvaBj7fpH2QbBlj1aZlu0VhC5VHRa9a1j5+mQy9fWxpWcStoc7OADfzbDtUXhFAMylqnXMZ/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rVI38Uud; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rVI38Uud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791720686; x=1792325486; i=markus.elfring@web.de;
	bh=97ys9gRqrEZ8QWJSZ5qvUMjJJLvd3tNrB4aJIYBAGhk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rVI38UudstmKB5sKXXGK+ilJln2x/NmDHH0rFJPjREqh4FP06bOduaU+/N8gTHfi
	 xvxVDD1oU5qIVauEYWv7ue8WdGswCHmwHQ5+FO3BYeQrNUOFKxv4PE5w+ZaRmRKcG
	 lgmv1AxzsLIkV+lPThw3G0ABEof61kGl0++CCwCIBWqiajMC8KKxRIzvktmX1Oj8b
	 9MzsIX888RAj5KfJj6hXl5R0Xozq4rGQQaZquAq9x9v45yIaZQcqHxH4sguEkELYP
	 d+wLYFzBFzBLivadArVt0QFqISylbPtm8EImFxQ/aDdpQxnBJP5jZSfyGcjhAuJyK
	 9JyKg4WgK0Q5ZWs6Iw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUlDJ-1x6hQt3Ax7-00ItcS; Sun, 11
 Oct 2026 14:11:26 +0200
Message-ID: <ffeb3e5b-d9de-4337-b250-e27667024461@web.de>
Date: Sun, 11 Oct 2026 14:11:25 +0200
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <error27@gmail.com>, gfs2@lists.linux.dev,
 kernel-janitors@vger.kernel.org, Alexander Aring <aahringo@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Teigland <teigland@redhat.com>
References: <ar4BZ26gjQEjZgIa@stanley.mountain>
Subject: Re: [PATCH] dlm: clean up a type in waiters_read()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ar4BZ26gjQEjZgIa@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:piw8jHfgBy8ySzubbHI4sEFqy0eLbdhbmsfRVrGJ4H5mYIfFxXn
 +41a1Y2z83FnC/jJ8zbLOcwsv3jiadh7kZ9y93kS34C8w9RrOrRHFhY7n57bm8YtD5XR5Ga
 oYGQGdj25J/T7o0FSu5CkBqOylVXJ+HsdgiDemqchgiHogaPxPX6TPPh37YBmuedN9/W0YG
 eoodW93X3gi3oQTCw08bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ubMxcasiTks=;H+QHJOS+IO5gE7dgMQnC5ka4WBc
 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

> This doesn't affect runtime but "rv" stores error codes and so
> declare it as ssize_t instead of size_t.

Can a similar adjustment matter also for the local variable =E2=80=9Cret=
=E2=80=9D?

Regards,
Markus
