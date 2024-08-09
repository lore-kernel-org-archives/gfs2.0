Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C4194C62
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209108; cv=none; b=R0rQQ9fGzAiryy1lpD+YtAj6jTCc/4sUE0sRU8wtcRd8ejQcdwnlqZ5XZr1G9EZHMQX2VgY/5cuCGaHa8rNLvehlqST14z0hFoE6OWR9yHwai60anLdXDjnUsL+16Qp+eBi9H3RIK6H3YqOVm38YHp2+gcmmpo2fgaCYE5Lp0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209108; c=relaxed/simple;
	bh=jOXOaRYT4L48wJhp4miCKXU2dG1qcgRd2+ZqF+ia1M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cp37lg15M5nhoV6sOetonmG8TFHiwrmEuR6KCnKCwCzHDNIvslB+HUsLdk6E135TcK8a+BG+m0nJYHxmOm5irBujEhz2d+GfK+8qcBsA1YU7qdBqVhso56qU6VByGbPbjQKwidrcDMs6QZi2BfiiuJKDZD81x/9zx/yC8P+g7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1uw508q; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1uw508q"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db19caec60so1365981b6e.1
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723209106; x=1723813906; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLy+w1i8+q3J1zYjzqllPpeRDTQRavcNaGacNPXrk+g=;
        b=J1uw508qSMO6oXWXqeEJx1LGca8JtoPLRNEXegFh0Zx2Zmxz6oceXmJQCYacgiVyW0
         nJBG7miwrZX2MK1sOI132R1bWN2CMIjAZ8DyjoJFUbfBrmogOBzvGP9QNHoBq+4Epi4U
         tIw2TiF+970xZW119C0Nq5mq6v9hf8bgV0EsmedyKhrq5Upn8QwLx5qBHDgwbhoQplsE
         5DYnPs1H/2AoIIeB4sEYMSJZQ/TNfHNfwXzI6ojPNPmjvbi7xz+73W7VrlAHpAXo5pF7
         TLBJ2cQJPEKTK/x1KRNF0laIyw8RPsOHRoNvW/ipsnSHc7RR8FXFXwce98Z13x0oTpVi
         +kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209106; x=1723813906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLy+w1i8+q3J1zYjzqllPpeRDTQRavcNaGacNPXrk+g=;
        b=Ktw/yACEFQV4gmXd9XimStP6TUDciGkjJKRMKalQckhq47RmUWqS67jIZny1mLXsb+
         eUu/JbcbMYKv4aMaTPuiDnPiBob8hnsEOd6gWjmDHyMlM3OJHTGByOAMXHaCBy1tDh1o
         5O+e0wVIEtlG4I8L+qoGjrE9OUEs3VHfo4lfvRzcpmI6mzusq5W7ZHDIU2VNyg6KoaSi
         2dHQ6dK3bIDeoziPDl2hX9Z3adEEobVU9cGnLynVIJMUW4sKULjZInippTclmhZP0KC8
         qif2DJBjDhsS9JxaRsUSiPD4O2qrFH0mXcNPLds9Xsr/zGsSNYU+bsFovBbDMg4+6UQH
         A5zA==
X-Forwarded-Encrypted: i=1; AJvYcCWFX3tf9tuOF/hYgwZzRUILfXaOP2vD7jh263lFqeSPtc7IHrnvItiOEXqeJzNtB8cCwkVS3hyXV2j7msQjUmtIG0dZlg==
X-Gm-Message-State: AOJu0YzW4yuIGwiErwdQaPK4g6FtJJt5NivEke/UZFJsQr1Eow2Ql/21
	xUDulK58vADHcj/RawhDXf7q4YhdAAInBcgps0jMkqJAGmyz3ZGawlODDwdF7B0uP5DnStIpChb
	AK9RDoyEMe766pBkDnCa2N0T+Hac=
X-Google-Smtp-Source: AGHT+IFh+5SDIMKVPJMEfKkArRSdLe+gdR/fEMyRksrtueer4tYEJVyB95v8DzaJtFGvzdhBu6HNqGhWwHIjD6xVK2o=
X-Received: by 2002:a54:4e93:0:b0:3db:50d9:c6ec with SMTP id
 5614622812f47-3dc416f10fbmr1292288b6e.49.1723209105655; Fri, 09 Aug 2024
 06:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1723144881.git.josef@toxicpanda.com> <bce66af61dd98d4f81032b97c73dce09658ae02d.1723144881.git.josef@toxicpanda.com>
In-Reply-To: <bce66af61dd98d4f81032b97c73dce09658ae02d.1723144881.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Aug 2024 15:11:34 +0200
Message-ID: <CAOQ4uxiWJ60Srtep4FiDP_hUd8WU5Mn1kq-dxRz4BpyMc40J2g@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] bcachefs: add pre-content fsnotify hook to fault
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:28=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> bcachefs has its own locking around filemap_fault, so we have to make
> sure we do the fsnotify hook before the locking.  Add the check to emit
> the event before the locking and return VM_FAULT_RETRY to retrigger the
> fault once the event has been emitted.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/bcachefs/fs-io-pagecache.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.=
c
> index a9cc5cad9cc9..359856df52d4 100644
> --- a/fs/bcachefs/fs-io-pagecache.c
> +++ b/fs/bcachefs/fs-io-pagecache.c
> @@ -562,6 +562,7 @@ void bch2_set_folio_dirty(struct bch_fs *c,
>  vm_fault_t bch2_page_fault(struct vm_fault *vmf)
>  {
>         struct file *file =3D vmf->vma->vm_file;
> +       struct file *fpin =3D NULL;
>         struct address_space *mapping =3D file->f_mapping;
>         struct address_space *fdm =3D faults_disabled_mapping();
>         struct bch_inode_info *inode =3D file_bch_inode(file);
> @@ -570,6 +571,18 @@ vm_fault_t bch2_page_fault(struct vm_fault *vmf)
>         if (fdm =3D=3D mapping)
>                 return VM_FAULT_SIGBUS;
>
> +       ret =3D filemap_maybe_emit_fsnotify_event(vmf, &fpin);
> +       if (unlikely(ret)) {
> +               if (fpin) {
> +                       fput(fpin);
> +                       ret |=3D VM_FAULT_RETRy;

Typo RETRy

> +               }
> +               return ret;
> +       } else if (fpin) {
> +               fput(fpin);
> +               return VM_FAULT_RETRY;
> +       }
> +

This chunk is almost duplicate in all call sites in filesystems.
Could it maybe be enclosed in a helper.
It is bad enough that we have to spray those in filesystem code,
so at least give the copy&paste errors to the bare minimum?

Thanks,
Amir.
