Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F882C11DF
	for <gfs2@lists.linux.dev>; Tue, 13 Oct 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896897; cv=none; b=kUoRab1JeLCeE1WSTyXaSmWwWE8Tjlw505nf1OWNbk1n/J+1MZDlFk9Jmcn6sOqwVTFo04xoSvkt+h4S15bic7/IpSupq26U7r8O2f+PtL0Jgj0kpFyziiqcn3NpvJw1M4LcmiS9i+vBih+6Pe6jfW6CIECYCJ5DKY22Uf+drV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896897; c=relaxed/simple;
	bh=hoU3TOgr/tEZhslHcS2tq2f22QCn7cWixxnhkmlEY30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yogzv/fOAmmsQN6z6ZsBRMwgz56RAAIVvkoxQ6JCiKBJ18tYt7C0Yn026btopfQhPNtbFtV4zy1oHDJqbKxvYZIUf96NXkYNBHIprxoYZTXWCmiOFDWREhHqKZhLyS49NqdZ77n8SyLv+iirRK/Y6GQjyBwhNzk7QeGTq4aNdew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LT/uIhWR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LT/uIhWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791896894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoU3TOgr/tEZhslHcS2tq2f22QCn7cWixxnhkmlEY30=;
	b=LT/uIhWRGVXA64ohpS1so82upuG9GIywPMAdE9v2tl+xfeNJfGJqv6cMf7f/G4qKQ+s0SE
	yWdTOEbS7KeZa4vJq8Dt65SOx+VrxDjdK4ddHDLvQa9K9xJ3MHTb5xDOTOl2Lk7zwMq1La
	VbSFCaUnno4TjiWoNaaHZh565PRha4I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-Tv8L8VnaMsWBGoPqTTYvBw-1; Tue, 13 Oct 2026 13:08:13 +0000
X-MC-Unique: Tv8L8VnaMsWBGoPqTTYvBw-1
X-Mimecast-MFC-AGG-ID: Tv8L8VnaMsWBGoPqTTYvBw_1791896892
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a166a9ea21so24357145e9.2
        for <gfs2@lists.linux.dev>; Tue, 13 Oct 2026 06:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896892; x=1792501692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoU3TOgr/tEZhslHcS2tq2f22QCn7cWixxnhkmlEY30=;
        b=PJHYBPBcOQq0EPF/qPaEk2zi4pPBgsRttaJP2HTEk2R/G1PLiSjTnVj2CKNWpqcBGI
         FseIp+5QRZKi4L98Y3MSDSTjMPWH3JjV1fo9SIYh4jEAYpoh43EuYkmSuw0osGkSEPGL
         oB648n8mgzuuD6MFxkN0ykvkTmD0NnUI5EonUDcF9nRm+YndwcSP62U+OsckAR9HYIst
         p7vpfe4w0omMMzqfSD1rphsZEvYfWZnyP/pm2Hb7Kf5fV25Cza9LrdEhG6nBid/HPAPO
         jf0ebBDGESBnTGewCeX90xPLLoPMBw5JWV4IfOfNBoNoT8A+V6haROkO90cBi3N/8pFK
         oeYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzujkGjWVeIT9ZSSy5THQiE9AMRe4L6X2FN4BbvXRhFJIM1UT29Vdk2FB6t9qYa8A8+foxb@lists.linux.dev
X-Gm-Message-State: AFq9FYIzAVQzHOv7xNntiEU25lz/1Lg8KgHLOoVXb471yAc5dsq8TkCS
	SRyRUc1K6jlcDUAJikd7yM9XxT4PLR1wFPSduxiil9GpWSXSTOfwoU1dZBdXpEXl032Xk8Es2g5
	9bIsgR+fzXmdWF9oLkQsTAuz3y+0hv+lJAdtihGjq7THEWWstHaHg3ZpzTcmMQEswKMmWflNXQX
	5V+XrFfukLDsz+XHVbJEGKocw2vd+g8g==
X-Gm-Gg: AYBFou1ETh0L0PlL3UDeTFpb8o92+kABOnz5NXl76p0DekJvooMaLd6Alb1psEg7Z5X
	14pn5AU9Bne73LXBdx6gTETRP4BHknB47wrXcQtkFgVzXBpW9xOp3/VGgXgVt3EfVeQbNS4rjbE
	uFP6gb/G8TylPo/RXM6BKOhP0SnuaVxypLsmamhcaZuoGkHsOMyc3es1Qj
X-Received: by 2002:a05:600c:3f0c:b0:4a0:1723:2d8e with SMTP id 5b1f17b1804b1-4a18e44691emr266635805e9.2.1791896892374;
        Tue, 13 Oct 2026 06:08:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0c:b0:4a0:1723:2d8e with SMTP id
 5b1f17b1804b1-4a18e44691emr266635145e9.2.1791896891815; Tue, 13 Oct 2026
 06:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ar4BZ26gjQEjZgIa@stanley.mountain> <ffeb3e5b-d9de-4337-b250-e27667024461@web.de>
In-Reply-To: <ffeb3e5b-d9de-4337-b250-e27667024461@web.de>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 13 Oct 2026 09:07:59 -0400
X-Gm-Features: AclHuK8Sj2_Nz53xtduLPLt43HBfIW0FUJKisfBY_Ut16Ue4zEZk3fhpsmezn3s
Message-ID: <CAK-6q+heOWNY8CY8dgotxzEeFC_-huHnnO2pgH8kJsJSGryOtw@mail.gmail.com>
Subject: Re: [PATCH] dlm: clean up a type in waiters_read()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dan Carpenter <error27@gmail.com>, gfs2@lists.linux.dev, 
	kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	David Teigland <teigland@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TBpmnqTOofdfLNDFVgJG6NdTGqNyZNDPvOCudUt2Q_Y_1791896892
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 11, 2026 at 8:17=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > This doesn't affect runtime but "rv" stores error codes and so
> > declare it as ssize_t instead of size_t.
>
> Can a similar adjustment matter also for the local variable =E2=80=9Cret=
=E2=80=9D?
>

What do you mean by 'matter'? It's declared as cleanup.

- Alex

