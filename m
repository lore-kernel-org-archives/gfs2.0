Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4533F5A4
	for <gfs2@lists.linux.dev>; Tue,  3 Mar 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541166; cv=none; b=McGrEHmIQ9eCQeZr5O/ujL89BMoWGHFOIoNuxz/wjn47GhMP7+WxvVSwUvIQOrX+6QYndOI8qyT+pFardN73YGNhSSqVPX6pgNsD6ablCvDqeyPsWuDrW6HqJaeWjmHoSVboODse0cErjfyzWDu2q4dyORlbE9y0u08aR5/r7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541166; c=relaxed/simple;
	bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wbkr9tTegyQ4OC6mff+Ryq3VQu6UBrRXqscy//go0g+idWKSTScV5wpLAf9iufuJgl+z1Qn1IZH+uzAgtH+39Z693e/YEnBML/1y3yR1cbwxsjhbwTEtvPK/bk1CSckA4SK+0QmE6327KubEjxfJhfzUghf5EN8dY3mzDuaCbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8dFu4S7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8dFu4S7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772541164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
	b=a8dFu4S7JefFGS+0kKamr7Vu2juHCbECEOM4LvUK4KrsLOmKKIQvnGTMf8pDGksBOPIUVy
	wHvV7cZaxrillKvA+VZG/0cvGpNHc5SWpp7jLJu+WKMb/H2Ai1aCpNumQhHbd7jEGm/ZFs
	GiqZhLRFQGzAkdbuT81Vla6cLZUgYqw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-P8JaQwWqM4-xjqvz8Bdw1A-1; Tue, 03 Mar 2026 07:32:43 -0500
X-MC-Unique: P8JaQwWqM4-xjqvz8Bdw1A-1
X-Mimecast-MFC-AGG-ID: P8JaQwWqM4-xjqvz8Bdw1A_1772541163
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7962f1424d2so91087797b3.2
        for <gfs2@lists.linux.dev>; Tue, 03 Mar 2026 04:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772541163; x=1773145963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
        b=vvQ7ouYpmeqLseGe4XJkR4u2dgnfzU49sRZa06n87gPkl+OSjxgsoS2merMG/PoWCr
         vfaO1ook1+/2JnVLodCpy6x5dUn/J7EqdJ/P27/KPNWhbWuAN3+d2g7WsW6WiPcckEKT
         5x94YNB9jshk9uUgNJLXGAOESsFMFTb1Y2v0NAVLK/WDJ5YIBIq+kdlABpOB4TcUhHAH
         wamTa4BvNWRnCtL/rsLv8oHOjh6xPrD/EnV6i91MVBUbFscNeOrbIkSG5qhYqRDPRncz
         RDgJf2eb8fPagr7xwMd70JF8fKlsvMUV3YdTpPwdp0z4/H5nkYl2BUhSzdXH3vIK42rp
         Lx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0lrBIYEOJx6iWtG+D988e9hrDSmnSw6pIE1/lH16rqmUzHawqRuCyi7gn1n2AIkp6mgfX@lists.linux.dev
X-Gm-Message-State: AOJu0Yzr8uTpT9/eAVUL7mmkQR/IAkREbPI1uj608TluiywVlgFERf2T
	TI1Xw1CzMLtKDoXKfN3Dl8YlYvKzv3DZJSvbu8KJ6X8iDDblw6g46VRLzF5CjfKQE2oUPolAKWK
	k58/5BoUs38lkVoYPl3WvIoCF3y36hckOC0O7vS7UbfyCB2Lm8+0YqCZC6fLeguhr2xlU+cnUbe
	NMLNiQJstPcsIwbIWu3fcZOYg42861pA==
X-Gm-Gg: ATEYQzyYT32s5g1yehL1PkpCexYlvsmnEXbx/fMMhPOXgoE9tlGsPymM3Q6EvlbYNbk
	3ECxwnUeOQK2X3WEbK4RDPevL75m/YxHVEDHl7Kh1Acs9HGJ7vH8YsB/3f0W8Ty7hOIxTZU8Cbo
	NvQKUKL1M91QzpqBGFpWxuXkntk0vMN5qLEkioVMxuRshihYOO6uA1m26GGWXYkU/FVC2rQrRvh
	/0PLswQVeJrCGuqdxbXYSxxmRNS7au34i6O93IApgfkGRVmhixvVrQRhSkovkQQuw==
X-Received: by 2002:a05:690c:4986:b0:798:61a4:e2cc with SMTP id 00721157ae682-798855a41d7mr139268287b3.34.1772541163337;
        Tue, 03 Mar 2026 04:32:43 -0800 (PST)
X-Received: by 2002:a05:690c:4986:b0:798:61a4:e2cc with SMTP id
 00721157ae682-798855a41d7mr139267957b3.34.1772541162941; Tue, 03 Mar 2026
 04:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260303101717.27224-1-jack@suse.cz> <20260303103406.4355-43-jack@suse.cz>
In-Reply-To: <20260303103406.4355-43-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 3 Mar 2026 13:32:31 +0100
X-Gm-Features: AaiRm51g_TgIhOkGLCDR-668UB9OmDW-WHgYo8dNTw7KZZwkVFcUvPwu-AmQRn4
Message-ID: <CAHc6FU61tUwnFf4pXWun_nLnL2jyUYHLKAN7C1hanbKk0GTZMA@mail.gmail.com>
Subject: Re: [PATCH 11/32] gfs2: Don't zero i_private_data
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	David Sterba <dsterba@suse.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-aio@kvack.org, 
	Benjamin LaHaise <bcrl@kvack.org>, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RSFFvnGR_5hLNnAYdHcnQz1L1DX2u3Vcb_O7x_Iqckk_1772541163
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan,

On Tue, Mar 3, 2026 at 11:34=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> The zeroing is the only use within gfs2 so it is pointless.

"Remove the explicit zeroing of mapping->i_private_data since this
field is no longer used."

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas

