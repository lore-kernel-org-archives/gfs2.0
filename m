Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334872E3715
	for <gfs2@lists.linux.dev>; Fri,  4 Jul 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653826; cv=none; b=eLVpasW8xjhmiho4ch9QXMZaEGYvhK5KR0yXBu3MY2lMLEUvJksxMJOGy+hEHVrsxvxSkcyNJ2AJhgswm4n+b3MJ36xRFPzqiOf3cjg7MK4k+xiygDIsF56ncLjqVfPXgAdq0QWi2YoR/DDL0hb9P8OlxbjqNuGd3ZYX3tqK5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653826; c=relaxed/simple;
	bh=vVHA5joY6IcGy7tC7wV6vefYzCBMz0qLNhnYoagx0xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZpfZhb9WNSdn4Z7NxEI8EdaA3bRQW2G3BSLn4wvfrp9NAeTWsKGzwzEffIXbPpYnmXGvVYiRiZ1Sx6b332Xl0GYiLATUTe0SumZtdnvwWNKqdzhdXb/h6IVaG9SLjy0EMHUw579ZHauKjQfQdUZ3b9HieDHTE+iS7SgFXt6pn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIbfu6Kb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIbfu6Kb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751653824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbhYGUKt21vSsvrvlY5/+X1CqwX2FHTTRQfj9BKsHGw=;
	b=HIbfu6Kbu2Xfo/S1qP4k/KlmwOGGfniW/yCA4p/JkvQFleQs8cVcGOhs3DDfwGqLheg1HB
	N09Ggt0qVtsgDFbUxoxOID0tjpoKS1/nqD720CPeOAfXtrgS8DcMbvXoQ+RHoE7+sU6i6h
	Gbt//NKXWwfH9wZQFOOTzPg4dfh0aiE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-I_w5A7j2PbyogzUK9SC_Bw-1; Fri, 04 Jul 2025 14:30:22 -0400
X-MC-Unique: I_w5A7j2PbyogzUK9SC_Bw-1
X-Mimecast-MFC-AGG-ID: I_w5A7j2PbyogzUK9SC_Bw_1751653822
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so778167a12.2
        for <gfs2@lists.linux.dev>; Fri, 04 Jul 2025 11:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751653821; x=1752258621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbhYGUKt21vSsvrvlY5/+X1CqwX2FHTTRQfj9BKsHGw=;
        b=XDPfJDU5Kycp5YI1+RjHqdLoFhNdFPP/UcleMG6P8jMSs7Q4nQiqBGqrIqsYHzEVZO
         nSk0rMVgC9p1lGPypXHi2T+hn+ph9YLdW5bO6hxqRSSCfMMJZaJnDu3+L8MtLtcmT/BB
         9AKa3I/QrrN4tU3I5oEUSnHwBx/106U9s/VlIPklZkbWv9vhJndW4zbGPb7rUx/Qp+uF
         VKBUlhA5kEqb5xRIDN5PVK9Y919KeBQJ4+AoekhBBLOSUgea7mM4qz+2O4OnPyo3aMCG
         OxlRvAffNu5l/HNS8ox01XAAbNc/RJsjF6lSnIMe5KJlMtg2WAvaj64+XJ3ZXX/239zT
         y8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXofFiAD+mfxpbCGIXFP6NhWRHEyFq+TziM8qVKHmzHSkP1U/GyLg98n8Hv8wgtJ1JMsVgo@lists.linux.dev
X-Gm-Message-State: AOJu0YzaIZeHMTGuo/DoZwSqoZzgz6gEq0KAMonDIZlgNKJo3hzuuFWt
	HFYRwYpXc2k6u0RsqXhKo1GPrZl2oKjH7MEMYINq4V7ZT6delyh9tNVxA33WqaTZBf/71cP360W
	i54MggnV4abs8w8070K0r9OO+9bUPxECqQDt8rHTOWH/YIKrBic5T5bQ=
X-Gm-Gg: ASbGnctgpWJqU+Sra6227ArS5rlc0YM7ARYHfQM9I2C9q/nF22JPGSdBY4r4GVDGdbq
	HLb+b7Oj22Hl1qCoEP3cXPCpgzf0ILKZg9Uzgg96T/rrqpAcily3uy6EvGNDqSm6HBUj08ceX/2
	SfrOGgH8XyM54Sl/ga8er1Gkuaa5CmuGMwlQSy7sXefxw0GTWTfUxzatBxmWasAqQOtJMIyejCe
	zo6uIx2hD0JsxDQ6fAXFEVuRvrkTpliQzrF+ZRdF9g3/CWwFJrDW0lMOE87WtfRIbYLxKbfrZWP
	FO7mGWzf3lCSk4xFDGigMMoBfvsO5yY4H1JHMLJSl4zxOBILMZUT8RYPmv/bsLw=
X-Received: by 2002:a17:90a:e18c:b0:311:c970:c9bc with SMTP id 98e67ed59e1d1-31aac53e092mr5110128a91.30.1751653821512;
        Fri, 04 Jul 2025 11:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP2Y0eWmCqueC8tDvUEnjDevhuNatGJ+2lvHHUenAh9gh4jAfLhteOmz1cOYIyag5h9l2T2A==
X-Received: by 2002:a17:90a:e18c:b0:311:c970:c9bc with SMTP id 98e67ed59e1d1-31aac53e092mr5110107a91.30.1751653821073;
        Fri, 04 Jul 2025 11:30:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae81c0esm2639666a91.22.2025.07.04.11.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 11:30:20 -0700 (PDT)
Date: Sat, 5 Jul 2025 02:30:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Glass Su <glass.su@suse.com>
Cc: fstests@vger.kernel.org, Su Yue <l@damenly.org>, gfs2@lists.linux.dev
Subject: Re: [PATCH] common/quota: adjust _qmount_option for gfs2
Message-ID: <20250704183016.ib2a7c22g4amcywf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603041009.59811-1-glass.su@suse.com>
 <20250620173839.q735lweoglone5cp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <089C8762-DDC0-45F6-8769-FD52A75CA626@suse.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <089C8762-DDC0-45F6-8769-FD52A75CA626@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I5_ALfuXwmdHE3KKxhXXVKp6PvyuxXm-B26qZzxl--k_1751653822
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 24, 2025 at 09:38:59AM +0800, Glass Su wrote:
> 
> 
> > On Jun 21, 2025, at 01:38, Zorro Lang <zlang@redhat.com> wrote:
> > 
> > On Tue, Jun 03, 2025 at 12:10:09PM +0800, Su Yue wrote:
> >> gfs2 supports mount options 'quota=[off/account/quiet/on]' but
> >> 'usrquota' and 'grpquota' are unsupported.
> >> So in _qmount_option, transform $OPTS to 'quota=on' first.
> >> 
> >> Signed-off-by: Su Yue <glass.su@suse.com>
> >> ---
> >> common/quota | 7 +++++++
> >> 1 file changed, 7 insertions(+)
> >> 
> >> diff --git a/common/quota b/common/quota
> >> index a51386b1dd24..4b8052e07dde 100644
> >> --- a/common/quota
> >> +++ b/common/quota
> >> @@ -283,6 +283,12 @@ _qmount_option()
> >> {
> >> OPTS=$1
> >> 
> >> + if [[ "$FSTYP" == gfs2 ]]; then
> >> + OPTS=`echo $OPTS \
> >> + | sed   -e 's/usrquota/quota=on/g' \
> >> + -e 's/grpquota/quota=on/g'`
> >> + fi
> > 
> > There's not response from gfs list. I'm not familiar with gfs2, so I have to
> > ask some questions about your patch...
> 
> Feel free to communicate : )
> > 
> > From the manual of gfs2:
> >  quota=[off/account/on]
> >  Turns quotas on or off for a filesystem. Setting the quotas to be in the "account" state causes the per UID/GID usage statistics to be correctly maintained by the filesystem, limit and warn values are ignored. The default value is "off".
> > 
> > Looks like there's only one mount option "quota=..." for gfs2. And I didn't
> > find a description about project quota, so
> > 1. What will gfs2 do if there's a "prjquota" or "pquota"?
> 
> The mount will fail if prjquota/pquota is in mount options.
> _require_prjquota() should be modified.
> 
> > 2. Do you need to replace "noquota" with "quota=off"?
> 
> Yes.. I forgot the case.
> 
> > 3. And "quota" to "quota=on" ?
> 
> The only case "_qmount_option ‘quota’” is tests/xfs/820, not in generic group.
> 
> > 4. Have you tried your patch on gfs2, can all quota related generic cases pass/notrun
> >   on gfs2?
> > 
> 
> TBH, not all quota tests run well on gfs2
> There was a bug which can cause kernel hang in gfs2 fixed by kernel commit 5a90f8d49922 ("gfs2: Don't start unnecessary transactions during log flush”)
> In v6.16-rc1.
> 
> > BTW, in this function you can see:
> >        # ext4 doesn't _do_ "-o pquota/prjquota" because reasons
> >        # Switch it to "quota" to enable mkfs-time pquota
> 
> The comment is confusing to me. ext[234] support ‘-o prjquota’ if  MKFS_OPTIONS="-O quota -E quotatype=usrquota:grpquota:prjquota”.
> 
> >        if [[ "$FSTYP" == ext[234] ]]; then
> >                OPTS=`echo $OPTS \
> >                | sed   -e 's/\bpquota/quota/g' \
> >                        -e 's/prjquota/quota/g'`
> >        # ocfs2 doesn't support "-o projquota"
> >        elif [[ "$FSTYP" == ocfs2 ]]; then
> >                OPTS=`echo $OPTS | sed -e 's/prjquota//g'`
> >        fi
> > 
> > please move your gfs2 specific codes here ^^, and give it enough comments.
> 
> There is one question from me about the _qmount_option() and _qmount()
> 
> Not all tests of qgroup use _qmount, some of them call _scratch_mount() directly.
> Is this intentional to avoid influenced by other mount options? If It’s not IMO it’s feasible
> to convert them to _qmount?

Except some xfs specific cases, I think only g/537 and g/230 don't use _qmount
directly.

$ for f in `grep -rsnl _qmount_option tests/`;do grep -wq _qmount $f||echo $f;done|grep -v xfs
tests/generic/537
tests/generic/230

By checking these two cases, I think their code logic can work well without
_qmount currently. But if you find some cases fail on gfs2, please feel free
to convert them to _qmount or fix them in your way :)

Thanks,
Zorro

> 
> > 
> >> +
> >> # Replace any user defined quota options
> >> # with the quota option that we want.
> >> # Simplest to do this rather than delete existing ones first because
> >> @@ -300,6 +306,7 @@ _qmount_option()
> >> -e 's/\bpquota/QUOTA/g'    \
> >> -e 's/prjquota/QUOTA/g'    \
> >> -e 's/noquota/QUOTA/g'     \
> >> + -e 's/quota=[^, ]*/QUOTA/g' \
> > 
> > I think you might need a word boundary, e.g. "\bquota=..."
> 
> Right.
> — 
> Su
> > 
> > Thanks,
> > Zorro
> > 
> >> -e 's/quota/QUOTA/g'       \
> >> -e 's/uqnoenforce/QUOTA/g' \
> >> -e 's/gqnoenforce/QUOTA/g' \
> >> -- 
> >> 2.48.1
> 
> 

