Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047921;
	b=SbTqkJv5EiKhlucMCrFdcEX5jl7QKEOfwYMCYNA7O2DelybeyWNWOapkXs9PZ+JtEHB3
	 Q07ksbGkTE2HPnd56pvfxnSB9QzBn/Ajk4WPWVub2XwfMRABYDnnySmXlK8bwgpkUXoFW
	 OyNYjpNpcur+Mt+yybWu39RWqhhDqKA5I2xnb3Q7XaHlilVzi5OCAxNITxEeff2Z7Xp/a
	 mZ1AL2dU8BOc/AZp+UHTJNlgVxot02URyxuHm41vgvzUMxot9pqTDjLyGoRCcqDFqleCD
	 VXEBKJwvDda+VAsJHL/FnedHI9Izj5IhFcdq5GNQRCyGy3rLG3ANnmL46YsbxnqkWeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047921;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
	b=IyxLvxbYiTxyjJdH7BjFzD+s5ZQ4Gr7/L/2tc+HMkB/nPRXE/KiQsfKk/jRSOs6ap7qg
	 kM913m3GXEawNvoGFZRO2S2uUvsqbfC0zz7r8Yokt0UxZ8fnGEILEj6CKY91WPfjPSMWS
	 3MQbTjTm81CN1+knNi2vXADNO6FN2E48z6GyvTnLtwbiCGbGi3gL7x9jZwd0+HfoB/hbS
	 F4Nigxo9p/IOs7kVKoUclbv/BATrSusAQ7BXPDA4FkoTdEimh/wPv0qz1qWavpzZSg16w
	 hKmzStSSmq5KV0FAUfqB5RIKh8E3NqdpO84+gpARG33+AIlZGPVYTgsUgdncPXpBUWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=figiuMqN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AEC60A2603
	for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 00:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52AEC60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=figiuMqN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795047919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
	b=figiuMqNPSbJSC+rppKYW73jTrxg0F5RFlFTF8isncIxQMPE1WxN7Bn1FHZTvLkpofJq4d
	7m420J1xkEdKbn3Rcx5/MaC0RJqvUstWY08DU3pgmjHol80seQFiw6J/Lwkk9/s2t1SRbD
	9rIFexGnSFloom9KDpPKlHqDR/WtULw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-LmeiasZqNda3YauFlQGSEQ-1; Wed, 18 Nov 2026 19:25:18 -0500
X-MC-Unique: LmeiasZqNda3YauFlQGSEQ-1
X-Mimecast-MFC-AGG-ID: LmeiasZqNda3YauFlQGSEQ_1795047917
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b3b7d66416so21995287b3.3
        for <gfs2@lists.linux.dev>; Wed, 18 Nov 2026 16:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047917; x=1795652717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
        b=ccMSSAovEA3FyIQ1JhBIeQexLUCxkw8j+/2Bwn9VCgiMhqb7Ujn8wSm5Kma65f/eQy
         Q/jOlXFiAwdaODAtk8UuoMj3xVFw4+6xAzuOlek3kj7VhtE1E72qwd0UGq2k1aVowVmo
         HUugrEOCIVLFAO1w5FUt0A/S+gon/4ZxAbKL9+Wzy6Wr5Z60zNWljtW3Hs45cfA4qrtJ
         xrmOAvi1jILMkBCFkYYR6ePF4OKDWmgaoRp7dJfcMZtXOTp0otdY4sLOfcnziM+r5c73
         OWLJaU/iiK0TNzd6Q4PyeBpTYEb5E6WWkE4QCcYqE1vrdLaEw/d+rSpGquuBA2Y2YxNw
         KvwA==
X-Forwarded-Encrypted: i=1; AL+hErH583Lvv5ewuGI35Up0okAKw4ys342gN/zK9TXy1gvNPnos4xQ0FCixupL8vjzwS7ORU7yw@lists.linux.dev
X-Gm-Message-State: APuU4Z8eRKqvm7C4cz/B3fwLayOfwBBeD2/jLw/ZO9OEnjP1LCDf2MUc
	PNd7UVG6ECVbSkFQF/JwIdod7ixR0kEDp2PouAjiAs/TNS5jwzdVXjceHKZRk88jsz815AeWgCP
	KIgSM3aW8X9D3hmOTrkwwvOLHlEJdAy8YhNL6RWgC9Z8Bk0opzcu/eW14HHfA5kyAUMGdUs64ZX
	/VbB3iDX5QoEf/Lh/+6WApoyiVEhRyYg==
X-Gm-Gg: AZFdTZdh+ZoTcafvh+JacJqx4ulvrVQOjTm4CFt9vXKtBT/sK5Yv3XCDuEt0be7G/n6
	d7msU+E9nU1i26cNGVzDbJdYIB5TXJ/4KReAryMRhPIRbQT25J0b8cxMX4rBenKkZ5SDb1m9pPI
	janEa2v4wWxeUz7gOBb4R6hatS02WW+U75INXHS66e0fqldAmgL3JxgtyWKQp/oeYwweuxAaoI5
	NfcmP/zFHg/5w/fH5Sb6zngfG0oezeIvE6n0bazCGzcqQ==
X-Received: by 2002:a05:690e:1553:20b0:67d:b309:a247 with SMTP id 956f58d0204a3-67dd3f89d1amr1300410d50.81.1795047917522;
        Wed, 18 Nov 2026 16:25:17 -0800 (PST)
X-Received: by 2002:a05:690e:1553:20b0:67d:b309:a247 with SMTP id
 956f58d0204a3-67dd3f89d1amr1300383d50.81.1795047916923; Wed, 18 Nov 2026
 16:25:16 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261116171044.6938-1-jack@suse.cz> <20261118145941.1063127-21-jack@suse.cz>
In-Reply-To: <20261118145941.1063127-21-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 01:25:06 +0100
X-Gm-Features: AclHuK8SUbQZgISlLcenRaPXTNhazVJfuhMt4GCT6fjiABD73HgWRuB83sKw5Dc
Message-ID: <CAHc6FU7qgJ1R-bz2icUyQTQFs7_mKt=tat-ut66K-cgn-uet3Q@mail.gmail.com>
Subject: Re: [PATCH 08/13] fs: Provide inode_or_folios_dirty() helper
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>, 
	fuse-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ELyyCXWk32M0rpJAU0Pm_2AqCcuS0bVnSGc8EvOX4bU_1795047917
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Provide a helper function checking whether inode itself or some of its
> folios are dirty. We'll use it in filesystems instead of direct i_state
> checks. Note that this check returns true also if only timestamps are
> dirty when lazytime is enabled.

This is confusing. Can we just say this here?

"Also returns true when only the timestamps are dirty."

> This is what users really want.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/fs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 025f5d890689..f602deacf953 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2228,6 +2228,13 @@ static inline bool inode_is_dirty(struct inode *in=
ode, bool datasync)
>         return inode_state_read_once(inode) & mask;
>  }
>
> +/* Check whether anything in the inode itself or its folios need writing=
 */
> +static inline bool inode_or_folios_dirty(struct inode *inode)
> +{
> +       return inode_state_read_once(inode) & I_DIRTY_ALL ||
> +               mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY);
> +}
> +
>  static inline void set_inode_metadata_writeback(struct inode *inode)
>  {
>         spin_lock(&inode->i_lock);
> --
> 2.53.0
>

Thanks,
Andreas

