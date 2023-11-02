Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5671C29A
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYCwu3Im"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698935876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jsCF0i5O6/gTr16YZpNXJMk9ajCl+87XqCHuQIk8JQ=;
	b=JYCwu3Imd/V74P67ge5HtNiwcAh1EpSea/ULaVbArMDVC7+ln307QnFAjmC8gJqd1hhcMu
	y6PavrCMbN4Y1EBIqeBMsWDu7LtAg/erCnxOrJGzQDd7KEXOdSzEF0qbuCuH1wiGnAqxb1
	U0FpISbq6bQ2eJVuzimmo4aLO5o1QAk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-LoW0jHu2NbKXqHQC8LHz3Q-1; Thu, 02 Nov 2023 10:37:54 -0400
X-MC-Unique: LoW0jHu2NbKXqHQC8LHz3Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c7558b89ccso69881166b.3
        for <gfs2@lists.linux.dev>; Thu, 02 Nov 2023 07:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935873; x=1699540673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jsCF0i5O6/gTr16YZpNXJMk9ajCl+87XqCHuQIk8JQ=;
        b=BrBQKfP4tjThfKK8QY3egpOwlYu8V+gom1B0DPg8doda1M8gg0WCYu8UcxZ5aS6PGh
         8mpyFGB3a/9CnZV61Lth3bokT6pq1JFW6WT/W4v8lcWnKYY+A1f+m8yvmeSZg36+YKP7
         DgP/hz4VTyeSPWkw7mfV6tJm7Xfabvc4ZJkBHsDTSEKSmhFnSb3pLbL+ed6H+YFHuL7/
         8Gh6e2zlZCwTlhKDNQ4wCWVsNT09pKrAk0Umt9WwIeEz0RSqgfObUEIxj6XpiwhhvDbz
         rgJ+mtEgoAqi3qt2fMHN5bNRgXwAaefndNbtQCmQ07CacFybe2I7qrHTMEivcsVgVSlk
         F5eQ==
X-Gm-Message-State: AOJu0Yz+WzfhzOWc+ZbRq+FXAj0240crHwgYoMjgpJVDfOrXtj1aDxS5
	KDDuH2R4dOwwXuyyTuvVVE0uzed9eGjxcIpV60zLSLTsyhLMJ0ZQSC3CCP2guXjADbV6cnRCX89
	dFuALY1eUvIMT6hOyE/abHCidmy13KJnCwGCYOw==
X-Received: by 2002:a17:906:c115:b0:9d2:63ab:6d4f with SMTP id do21-20020a170906c11500b009d263ab6d4fmr4566399ejc.55.1698935873324;
        Thu, 02 Nov 2023 07:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERhFhafae76zUUdYJkyHMjhO18uMk2/F3HJt78Ghicsp55KLISPLQmp4pEBzxjiuTwfkA2ALEKRA7R02mMtlM=
X-Received: by 2002:a17:906:c115:b0:9d2:63ab:6d4f with SMTP id
 do21-20020a170906c11500b009d263ab6d4fmr4566388ejc.55.1698935873065; Thu, 02
 Nov 2023 07:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230925201827.1703857-1-aahringo@redhat.com>
In-Reply-To: <20230925201827.1703857-1-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 2 Nov 2023 10:37:41 -0400
Message-ID: <CAK-6q+hrsfCn+y3yjqnti9JUfSOhOWgiEtSioukL5H3dA6-_8A@mail.gmail.com>
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, gfs2@lists.linux.dev, jlayton@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 25, 2023 at 4:18=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> This patch adds fcntl corner cases that was being used to confirm issues
> on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> implementation and in those corner cases issues was being found and
> fixed.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
> changes since v2:
> - move fcntl tests into one fcntl c file
> - remove ofd and same owner tests, should be reflected by only one test
> - simplify commit message (remove testname out of it)
> - add error messages in fcntl.c to give more information if an error
>   occur

ping, any comments? Would for me nice to have these fcntl() tests
upstream and have a starting point to add more tests regarding dlm
plock implementation.

Thanks.

 - Alex

