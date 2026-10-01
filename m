Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD833345EB5
	for <gfs2@lists.linux.dev>; Thu,  1 Oct 2026 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895916; cv=none; b=hfly9J7y2XePE7905Y/3uB+a4Al3A2OpDLr6J5ZOiLq03zw2kohWv2wl3WqHaactHw8xTHiJujOPiG/oiIfigip2FDS0DV7Zg/fpkkrPPkJvoPxXBApiMdn6EkbhKZTVkO3FdwmM1QE2uXuuz0Yb+gjqaZoRMzOora4Sl9sJkT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895916; c=relaxed/simple;
	bh=vw2nzUr45rmNtePuF5woJ4YHliw70BsRrsUc60hfEeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+qj/2ocPG6t1KKPyIOc1o50C18mNFQumy+wJuLmlWiNkdTBHt7lPiTOl5/r2rQ0F0TyfivE0efmzwLsdK6nhahHikKkyfBY2M0meNswBGdmGispcOcMCNA4WZqILlbjFTkFqrXiOR6T8p3sqUnIrf7Blnm1tzcH8v1M0r6eio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmDkH1KK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmDkH1KK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790895912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSOgoIY/XNyZCrjm6JfgZ+KbRhq2HncbGvnq6vOvd/Y=;
	b=YmDkH1KK5rC3XOuZpvEkwvuUlqC6Sm0lkr2xGxfZD//M5AwfO9AcTy2hTFqPnWPYl7fHx8
	g4qKFSIO2i/DpEna4cX4yCN1C6jpTKOjqZIdJyMD+LNJRZbOwT5ETxWvRnJPz1sIeOAUtX
	kE5YotJfEQHs50np0DWmGFuhu9wEzj8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-pWhFdy98NLK7witLVKqSMQ-1; Thu, 01 Oct 2026 19:05:09 -0400
X-MC-Unique: pWhFdy98NLK7witLVKqSMQ-1
X-Mimecast-MFC-AGG-ID: pWhFdy98NLK7witLVKqSMQ_1790895908
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3a64e917254so43566431fa.2
        for <gfs2@lists.linux.dev>; Thu, 01 Oct 2026 16:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790895908; x=1791500708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSOgoIY/XNyZCrjm6JfgZ+KbRhq2HncbGvnq6vOvd/Y=;
        b=DeGTWB+EcxKPG0D/usZVT5gohrd7pQzIr/jPtJh2jElfe/KdhxveKLkKMV4bJ+CgSa
         1vclJAxy7UGUmLGLdPU7c1trKdm7Z8xvwBKwx46ITwp81YnXsVzzB9RSopHlrYSmgDLn
         /a/rMst7msN+H7axB6IgAAuCzUsipe/yq8FpgpF7JmiIlgYb1ifFfa6N0y0ICWHpi9L7
         +PoUdjJ5Tz1t4DESOiF5z8nT6xzg1asxA7gHtqsh2+7G7p7rEl0xs+DhTqx8TxeWEgT3
         +e8xhbErrrQSummEdDIHaX5shrzQ10FL/jkfPhNgc6jP/oSYWLWHYtl3/fuyWiIBpNYf
         VoPg==
X-Forwarded-Encrypted: i=1; AKwUvBwzSgdZv14fGnf2hDrSTI8EPXQBx2ZXjnDnsSjwx4U2puaZDwL5a+A2tM1uuWb3weDu5lgA@lists.linux.dev
X-Gm-Message-State: AFq9FYJQEubHu77mmHMo5+u6ieDwcrnex250CESfONl+kV1I5HqLMOD+
	lFl/Eqyn8G7nCm98ZA5q8r/SFfLSIeukGgvtMLpN3ttsF0s6+1k4sbKl8Jc5DtmORvjLJ7G1ESz
	QN1QpaqyQedxiQct8dkvafeO4YeL7h7Y3O+R3PBPq7DseakuUw87bvtWt+GKG/exw9yk2DCLNF5
	vty36u9ZQ0cVO+npI9/ugp/eAtQQMJxw==
X-Gm-Gg: AYBFou1GLh9s3JpWtmlb1ecVHOzW/R4DxgnOtVEMrIKuTGpq4p3pMnmaZORcjTkvDdg
	R564XAgWfIgWhsvhIECiO9zo/F9z397MX6R11gx1esOFhV8qr2PJ9YIEIDp+RcQqzM8qzif5/AB
	wrdXeoyy7SiMwGkKJXE1Bt9euuCIQEnSpSDn3oPvERtaCgN2hA/9RuYbAs
X-Received: by 2002:a05:651c:19a8:b0:3a7:3ad4:943e with SMTP id 38308e7fff4ca-3a887787589mr1664711fa.12.1790895907790;
        Thu, 01 Oct 2026 16:05:07 -0700 (PDT)
X-Received: by 2002:a05:651c:19a8:b0:3a7:3ad4:943e with SMTP id
 38308e7fff4ca-3a887787589mr1664651fa.12.1790895907444; Thu, 01 Oct 2026
 16:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260907062157.8474-1-hemanth.selam@gmail.com>
In-Reply-To: <20260907062157.8474-1-hemanth.selam@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 1 Oct 2026 19:04:56 -0400
X-Gm-Features: AclHuK_0RZo4hr957aP6ijYk-eInWMEECGfCqShXUgsVoVy4JqkmiHVTPtkrqKs
Message-ID: <CAK-6q+gdn5C1uq3Sjig7dO86T5_Ze3Fm1BsZ5XQU72XwJBNrkw@mail.gmail.com>
Subject: Re: [PATCH] dlm: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tXY7JP7GvuoiKjzjd7sg9gjXlqzEHX8IidztBt27KTI_1790895908
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 7, 2026 at 2:22=E2=80=AFAM Hemanth Selam <hemanth.selam@gmail.c=
om> wrote:
>
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

