Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DE438463
	for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226265; cv=none; b=tWI6mDmn0fTpHbgqYPDMYCgVzNy4wFis6U+NuOy8htioNtGCZtB2UdsLNJM8sNCXfhKNlNAlPs3naVYUQ3dFYyUAB/1wBJXIydcIxlykZ9VCTgr+eskFSYXDD118dI97IPDLlb70PY//UNrWbsULphSpWFhiwi/UD6CdnavCtKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226265; c=relaxed/simple;
	bh=NiIFchjgdvSNxzMnvKsLLJ25ytDAGNVtxyH8Yel3sE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGS5bsaXzMiDmhYJAun/2FhobBHyqL1VrwTegQqfhU5/xJ1ph46/v6omc/oSRlW7JRVv4zAIpACng7RnWJWmswwhhqkgz0QiTA7tISOTFC/QTtHlborq0Mp+oEwBiWH9KiNuEkBKoh/+Ccp0Uqhcfzf9NuIZVsseajFFyn79htA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LykSRQDO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LykSRQDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784226254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdMB3+lhQNu1bsY6NEc8NDYIfUuZEGsf32XvL06WDxk=;
	b=LykSRQDOKBwGIwfIyIm7pm2qY6mkQeIENEOBLp4KNUWAG/+OzR+k+zs9ofhgvTLIpAC0ix
	BxKwCcElH6plVEn/Zdoim2NOsdkQ5+T6GcyS3uSgDazCTWBIPIyHTdJNg1LijOqYQJjUEx
	yXZdp1xxqizlPJx8WH1sRUp3XLqNDAg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-UZbxAss2PliUlBhwlXMO2A-1; Thu, 16 Jul 2026 14:24:12 -0400
X-MC-Unique: UZbxAss2PliUlBhwlXMO2A-1
X-Mimecast-MFC-AGG-ID: UZbxAss2PliUlBhwlXMO2A_1784226251
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3997d4a5085so32445591fa.1
        for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 11:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226251; x=1784831051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdMB3+lhQNu1bsY6NEc8NDYIfUuZEGsf32XvL06WDxk=;
        b=myg2ZpRDZa0McSN+jtqPIsacoXgcxsLFf1xNL+YMv14eh+QC0OHmRPCbn6rSKBBgaw
         s+kW3HGMup5wxn3R5U/StRBh/Mof+7vtRMR2SKO6NgOu1fsn6xnavgVWJ1C/XCQ42nNl
         TWaorDVF97UUf2hE+w8RXXBxEjcWpnV9WDT1R4ZxWG8Op6PN6ApU5c9bjo77Z+VxQchy
         DQeYydjzIOXqsjmL/RMdt34Hrs59jLsf3J8TgqesEgU0UXY+3VubkzQ3QHFzFY3w8lve
         96UpgmOuNWcA20uMtSvzLIzSbf4/VwxPtxI9eobWCbU93AJY9cxC4NGzYXl2dnFXKjc/
         V7Iw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5QBf2BqFFb2ndbs37pUmnszeLJrbnNzJr9IV20kLEVTKoZijnGwov+NWZPSHsMvpEp+Hb@lists.linux.dev
X-Gm-Message-State: AOJu0Yw14Aba2PEwCE1wBfN0dEfV/+zFaU2Gaadle5ximcGdmUs4+gRl
	vmQeeeaCU2eVZI19PTM+zp5udHMddzcUPeSVA6V1ezPRpMqjjVOQ4nllnhNWY0SibO6SpDbk+0H
	O2C1KtU8mfIBvH0qb1nmlAs+CAP8kU25Xqy+jaX5FsB0PWR+Q8rnISzUL2HiXoMLZ1DzqixRPqD
	0YcGVJu8rNoqY9tHm8e3XeSl8ZStuqDcumqp1RNU6X
X-Gm-Gg: AfdE7cnoIcmXAw64QGMhR5XRj/pLIKCFnCbkoRg/DBFIE1n0MqPP7QsZIjCpfXKCBod
	/2ShZf5dbhVltWhsI13vRNL8RwVyX299e7lhokEDLG2FLgfilbhCkJgrWw9YN/02EUyCXJXIBAI
	yoM11Xuvv30klYADQ9JCw+p0vI3MiqbK8egCxqAuNzsyHAB+IlZCHQDwX5qLO2sYGHpLQxOVBIE
	lzrnCDdVx1lhQqm
X-Received: by 2002:a2e:be94:0:b0:39b:d76:5cb3 with SMTP id 38308e7fff4ca-39db6d59f55mr20395621fa.29.1784226251194;
        Thu, 16 Jul 2026 11:24:11 -0700 (PDT)
X-Received: by 2002:a2e:be94:0:b0:39b:d76:5cb3 with SMTP id
 38308e7fff4ca-39db6d59f55mr20395551fa.29.1784226250761; Thu, 16 Jul 2026
 11:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260609001538.1235326.296e93c4065a.dlm-user-short-lock-name-oob@trailofbits.com>
In-Reply-To: <20260609001538.1235326.296e93c4065a.dlm-user-short-lock-name-oob@trailofbits.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 16 Jul 2026 14:23:59 -0400
X-Gm-Features: AUfX_mzBTsLhdcXBg4_LSla7zF0c01g89rPhs5RmFU8YWkfJg_cnlqGb6vAZZSE
Message-ID: <CAK-6q+hf8X9g+hiPC5A3n4rr1C=vWjakB4tU-sRFQHEL9finMg@mail.gmail.com>
Subject: Re: [PATCH] dlm: validate userspace lock resource name length
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: David Teigland <teigland@redhat.com>, 
	"open list:DISTRIBUTED LOCK MANAGER (DLM)" <gfs2@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JJS27BM1855kuF4VtUjqE23yTFDlo9Cu-fVcD1XdjOo_1784226251
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 8, 2026 at 8:16=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> The DLM userspace device accepts a flexible resource name after
> `struct dlm_write_request`.  `device_write()` bounded the total write
> size, but did not verify that `i.lock.namelen` was covered by the bytes
> actually supplied by the write.
>
> A short `DLM_USER_LOCK` request can therefore claim a full
> `DLM_RESNAME_MAXLEN` resource name while providing no name bytes.  The
> request path later hashes and copies the claimed name length, reading
> past the `memdup_user_nul()` allocation.
>
> Reject non-conversion lock requests whose claimed resource name length
> exceeds the flexible name payload supplied with the write.  Valid lock
> requests with complete names are unchanged.  Track the payload length
> before compat conversion so 32-bit requests keep using their own request
> header size.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

> ---
>  fs/dlm/user.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/fs/dlm/user.c b/fs/dlm/user.c
> index a8ed4c8fdc5b..205364329ce3 100644
> --- a/fs/dlm/user.c
> +++ b/fs/dlm/user.c
> @@ -511,6 +511,7 @@ static ssize_t device_write(struct file *file, const =
char __user *buf,
>                             size_t count, loff_t *ppos)
>  {
>         struct dlm_user_proc *proc =3D file->private_data;
> +       size_t name_payload =3D 0;
>         struct dlm_write_request *kbuf;
>         int error;
>
> @@ -544,6 +545,7 @@ static ssize_t device_write(struct file *file, const =
char __user *buf,
>
>                 if (count > sizeof(struct dlm_write_request32))
>                         namelen =3D count - sizeof(struct dlm_write_reque=
st32);
> +               name_payload =3D namelen;
>
>                 k32buf =3D (struct dlm_write_request32 *)kbuf;
>
> @@ -560,7 +562,13 @@ static ssize_t device_write(struct file *file, const=
 char __user *buf,
>
>                 compat_input(kbuf, k32buf, namelen);
>                 kfree(k32buf);
> +       } else {
> +               if (count > sizeof(*kbuf))
> +                       name_payload =3D count - sizeof(*kbuf);
>         }
> +#else
> +       if (count > sizeof(*kbuf))
> +               name_payload =3D count - sizeof(*kbuf);
>  #endif
>
>         /* do we really need this? can a write happen after a close? */
> @@ -570,6 +578,15 @@ static ssize_t device_write(struct file *file, const=
 char __user *buf,
>                 goto out_free;
>         }
>
> +       if (kbuf->cmd =3D=3D DLM_USER_LOCK &&
> +           !(kbuf->i.lock.flags & DLM_LKF_CONVERT)) {
> +               if (kbuf->i.lock.namelen > name_payload ||
> +                   kbuf->i.lock.namelen > DLM_RESNAME_MAXLEN) {

there is later a check in "set_lock_args" to do a "if (!(flags &
DLM_LKF_CONVERT) && (namelen > DLM_RESNAME_MAXLEN))" check.
However there is a trace call in between that can access this array
out of bounds area if namelen is above DLM_RESNAME_MAXLEN.

I will add a cleanup patch to my list to check for "sane" parameters
as soon as they are known...

- Alex

