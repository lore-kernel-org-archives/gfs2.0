Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7E18FDC8
	for <gfs2@lists.linux.dev>; Tue,  3 Sep 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385649; cv=none; b=UgEzdATbRGTBaTFT4qG9kfPKo8mvqmPQBcec25dLNatni/hym4geaScM3FmM5CPQa+FyzziwAbUx2lQKtrqBWtDSluhpnRVHq+lyZlUsjU/aKXaPHnbrTyvR9o5Z1OQr6sNIgIVUGklqBl8fo2Khb5gCfWxE3qAaPF57wTb8C4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385649; c=relaxed/simple;
	bh=vilaWUSJal499Udwz4dDYaxHQfBpjxAcpzruaqhWlWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNRuWiVMjd061pN0tIo+OINvsioqARg9Cf2PpzvPtt0A5sQTR0uv49NcFeVw/BnrB1dc6K6wSV55iHQEWH4AA/EHPbH0DuQ9vIitMSWR9iD9ILYshv25WKNxl+spiKcfCm7gcmC8erUGRWKpQ3C6xv46QHfqGrzaiksShSyn7i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggPmcnud; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggPmcnud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725385646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNXqs/lNoSaUpgBeX3QA/3YkwVc/xXeOo6r0HFbZOuc=;
	b=ggPmcnudUnr9O/swBecZOaZ3wKpMVHLK3zkblyDlLP5c5HThb85RPUjojpmCDCv08V2cRv
	kMz0wJRoqpyURQkyclpsXQILGSUXyRB91KeGW6k2jt0FRDr5HLusYwFrUqrqLHl1YZxKmm
	5YX2FgW3W6BYNz0TCgT/910tTPabOeY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-RbHKsSK-MTKFm1Xb480afA-1; Tue, 03 Sep 2024 13:47:24 -0400
X-MC-Unique: RbHKsSK-MTKFm1Xb480afA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7cd98f27becso5630966a12.3
        for <gfs2@lists.linux.dev>; Tue, 03 Sep 2024 10:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385644; x=1725990444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNXqs/lNoSaUpgBeX3QA/3YkwVc/xXeOo6r0HFbZOuc=;
        b=AfSNK/MDgTX3vN+NBlhRDf5jR/pHpQiuJh1Y6ZcuUh+CT/Y882sadU4KqeVFDm8Tfc
         uEdXTG3abSuSOBxE5ZXqCAlx5ZLT4JZAcXfPlcb2uSlU42g/5AXsrO1nOGf8WC1jHPEh
         nrhxDPZFs26AR5aK/H7j4uwqvBnfKCgpZ9PKx8t6h7fD4V/mVS3Tvy/mmjN95pJB2IuE
         iCtMGIUcR05vTO5PUyBMUAbsJvLeSglr6yD1rVBFJgXOTGcNJSVWbmXwxpntPrPzhYKb
         6Wpbn9OvJrY+O9dYdwiC39nSx21WQSq7ue8JMWhF6gyp923qvJA6knDmFZwy5hKLjtmg
         GDNQ==
X-Gm-Message-State: AOJu0YyNfWHNQYluUBxfGPUsziKCxeYOgd1OyeWsucMwxrFfrBQQR2A4
	+C5Vzh0tLM+Xw06UR3ExPpXbJrYBTcZNHtFKQQP6eYvG5vP0WeKN+KWYOfjF/sFys+01bnuXTKg
	sBJSRafwqSZ2VYGBuGElAGTum/i3jKbUJNw2otvARDXkXKBCLvFYRv0RILPECajeiZ7bOpi+Vv1
	/e8p1Ffh9YPxZVeCUaFfastElosA==
X-Received: by 2002:a17:902:db0d:b0:205:7835:38dc with SMTP id d9443c01a7336-20578353a3emr94726375ad.60.1725385643787;
        Tue, 03 Sep 2024 10:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrZyUIweOEljpt2l1gAEepYaw7yFw7Iw8NeKb3l3vIGgC5JNPoK4i1YlSRAOirQL3ons22O9Zd9Id9Io4MdQI=
X-Received: by 2002:a17:902:db0d:b0:205:7835:38dc with SMTP id
 d9443c01a7336-20578353a3emr94725985ad.60.1725385643238; Tue, 03 Sep 2024
 10:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2142bfe8-c91f-4c56-a3e9-3d5cf11826a2@roeck-us.net>
In-Reply-To: <2142bfe8-c91f-4c56-a3e9-3d5cf11826a2@roeck-us.net>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 3 Sep 2024 19:47:11 +0200
Message-ID: <CAHc6FU62ShJjBLujC4=zNupXrWWxL7JkQnX1_Xra50rog7HFwg@mail.gmail.com>
Subject: Re: lockdep warnings in gfs2 code
To: Guenter Roeck <linux@roeck-us.net>
Cc: gfs2@lists.linux.dev, Matthew Wilcox <willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 2, 2024 at 5:14=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> Hi,
>
> I keep getting the following warnings when testing gfs2.
> This is with CONFIG_LOCKDEP=3Dy.
>
> [   12.210205] gfs2: fsid=3Dsda2.0: first mount done, others may mount
> [   20.014136] ------------[ cut here ]------------
> [   20.014417] WARNING: CPU: 0 PID: 2154 at include/linux/backing-dev.h:2=
51 __folio_mark_dirty+0x318/0x350
> ...
> [   20.016969] Call trace:
> [   20.017017]  __folio_mark_dirty+0x318/0x350
> [   20.017088]  mark_buffer_dirty+0x8c/0x18c
> [   20.017145]  gfs2_unpin+0x6c/0x434
> [   20.017198]  buf_lo_after_commit+0x6c/0x90
> [   20.017253]  gfs2_log_flush+0x3b8/0xd08
> [   20.017310]  gfs2_kill_sb+0x3c/0x1fc
>
>
> [   20.033440] WARNING: CPU: 0 PID: 2154 at include/linux/backing-dev.h:2=
51 __folio_start_writeback+0x2f0/0x32c
> [   20.033551] Modules linked in:
> ...
> [   20.035108] Call trace:
> [   20.035148]  __folio_start_writeback+0x2f0/0x32c
> [   20.035210]  gfs2_aspace_writepage+0xdc/0x208
> [   20.035268]  __gfs2_writepage+0x20/0xc8
> [   20.035322]  write_cache_pages+0x70/0xe4
> [   20.035381]  gfs2_ail1_flush+0x20c/0x600
> [   20.035436]  gfs2_ail1_start+0x50/0x80
> [   20.035490]  gfs2_log_flush+0xb40/0xd08
> [   20.035544]  gfs2_kill_sb+0x3c/0x1fc
>
>
> [   20.043396] WARNING: CPU: 1 PID: 79 at include/linux/backing-dev.h:251=
 __folio_end_writeback+0x368/0x40c
> ...
> [   20.045083] Call trace:
> [   20.045123]  __folio_end_writeback+0x368/0x40c
> [   20.045195]  folio_end_writeback+0xec/0x140
> [   20.045252]  end_buffer_async_write+0xe4/0x1a0
> [   20.045311]  end_bio_bh_io_sync+0x34/0x74
> [   20.045369]  bio_endio+0x184/0x26c
> [   20.045422]  blk_update_request+0x230/0x4e4
> [   20.045496]  scsi_end_request+0x30/0x40c
> [   20.045554]  scsi_io_completion+0x48/0x5b4
>
> This is seen all the way back to v6.1.y.
>
> Would it be possible to get this fixed ? It should be easy to
> reproduce by enabling lock debugging.

This is a known issue; see [1] for a previous discussion, for example.
We don't have a fix; for using lockdep on gfs2, we remove that
assertion from backing-dev.h. A proper fix would indeed be great to
have, but I've never gotten far enough on it.

Note that Matthew Wilcox's recent aops->writepage removal patches [2]
seem to reduce the number of warnings somewhat.

[1] https://lore.kernel.org/cluster-devel/20210713180958.66995-11-rpeterso@=
redhat.com/
[2] https://lore.kernel.org/gfs2/CAHc6FU76ioJT4UDRPQNMZ94QOgs6ReuM2WUcSAD4i=
rqERmGckg@mail.gmail.com/T/#t

Thanks,
Andreas

