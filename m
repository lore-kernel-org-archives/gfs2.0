Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193852C17A8
	for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930881; cv=none; b=FCef2udz+8A5AoZ0BUwttY6bq+nTOlCFGZpmDKiLUygxVzC6WI2BgwCmEsaJxasKh2aYnkLoiQt1NWqS/upZYrP3W9dNXTfs9itSiOVktp2mUfcAidYKTm83GCtF4zop0aiOeWeD5cCwH7EQYdzwjE3dB0henZTf2pUCxvrDpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930881; c=relaxed/simple;
	bh=g+1IpmXZHVhSaI36IiFmvf9OnVuDJAsRHfee8KcFjIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3BfKECN4amVEdOCfrWhDhgTQWi2RZgoBjwV2sH01DqT++sY7qt+Kxr51/F8wsMnqfYExIsgi/icBuOFW/WqjbqypGukRL+tQfywOtgrnOQgwNc6+btw9VoJc3Ul4OFyANdZYR6VfavNEzyTXli4/i9TPo6WPUvvRezLKWlvEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCDi4fuN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCDi4fuN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745930877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg4h9YyQkAOzT2arO1ZyfyEQiyOT7kTraAVcew/yQu0=;
	b=XCDi4fuNkM84vbkmg6Ms3/sKjNIG4zpk20VLBWUrJ2dx/LOEZDIRHN1QN/QgDLGwAoHNkR
	1gOtsAzjtwbMm/57+7to3dYQOqqkNnCeRfAmiweDwcrl+R2v/WJsITkKhXJ/VH+4a74Wl1
	NYpKOT3MwjhpnMmQD6jHRdsudgH/uUs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-6VCvyfIRPMWiTMYQfL1MHQ-1; Tue, 29 Apr 2025 08:47:56 -0400
X-MC-Unique: 6VCvyfIRPMWiTMYQfL1MHQ-1
X-Mimecast-MFC-AGG-ID: 6VCvyfIRPMWiTMYQfL1MHQ_1745930875
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bfd1faeeaso25160631fa.1
        for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 05:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745930875; x=1746535675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg4h9YyQkAOzT2arO1ZyfyEQiyOT7kTraAVcew/yQu0=;
        b=Bom6BuMnXZ2vZbKNKFgtGyMm75uMfFKWLlr2Gu8QUj6TWA4m8JUbdLIpcwxWctS8Vh
         YZl5JIx0U0g5dHCnSs/cwTdcmu0SHMtZYSIIfr9RqrVmWf1ehoS39jfihs07eT7ygDU8
         ChJWe+r3nXe327Huq/AmcUsN9uo2L3+BXEZVfg2I3vB1hnpvZxIoRa8qdkp2PWlBM19m
         +il2SuTq7eE6n18zo0f6XpClnRhhSEP4gVlKLMAUE4g7CfHBDDBFWKdIS3HWGEhDJ+FA
         +Pr+LDoiPt5c+dUekRHsdcUqqqMrPO4xjNDnvVJs6TIwjluhXWzboaHSne6BHCoxPPvY
         Ncaw==
X-Gm-Message-State: AOJu0YyEgdW2ev0022725JNLIm3jH3tBZqXVb5dUa5XdDn4i5DStR0vO
	854depNVQ5vHQBlliLLiDDdXd6uApGUaUGNQAr93uttufK3+8oF6vDBuE+8N+dTiYyf6LPag8LB
	pIOuagKiGzcz8HRkef2pSJCeHeFkJEl9Pq+OaVDCeANKSLbR0o+dnnCKP+NTUYzBEFNFn3nWJ4D
	nB7R7lDsccAeKDoRvroH1pGXMX1w==
X-Gm-Gg: ASbGnct1zsD522SbvvhFa4vJwseBMC6ibcTc3J7zkGHgMVRhJt0c4qO1AdxJOdajKpt
	MSJmf44Wj3KaLhLjb6IOjMTuySZKH6nmR7MwVx2pKcSHDouDqc+LDiSaimv33tAZEC6x2J7AMQy
	PG8Oc6J4CFSJkj+wSRnlyJsd66Ag==
X-Received: by 2002:a05:651c:221e:b0:30a:44ca:7e74 with SMTP id 38308e7fff4ca-319dc0204b2mr41901801fa.12.1745930874655;
        Tue, 29 Apr 2025 05:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjnGCYwFnJPAv/DSUkOfBbt6SYisLDnZ9ASBXp3itgwOZqg19ut6FHUdfcILeBUogALhkQy3SQAIFv/qfpjWc=
X-Received: by 2002:a05:651c:221e:b0:30a:44ca:7e74 with SMTP id
 38308e7fff4ca-319dc0204b2mr41901701fa.12.1745930874205; Tue, 29 Apr 2025
 05:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CCD305AF-06AA-46B1-8761-4DF1F82B8054@suse.com>
In-Reply-To: <CCD305AF-06AA-46B1-8761-4DF1F82B8054@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 29 Apr 2025 08:47:42 -0400
X-Gm-Features: ATxdqUG62sPIwrpxIHqepII9OZJcTxuqPEXCU3DKVUL8PH7zX7As42gqr6daMZM
Message-ID: <CAK-6q+jv5hhhEZ8k_wvzmf0G3RH-qr0kMHJdj3AO+sGAizyuQQ@mail.gmail.com>
Subject: Re: [Question] dlm: shutdown sctp sock always timeouts
To: Glass Su <glass.su@suse.com>
Cc: gfs2@lists.linux.dev, teigland@redhat.com, 
	Heming Zhao <heming.zhao@suse.com>, Lidong Zhong <lidong.zhong@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oJzT_bxzfcT3oHnpSLNVkN04Z-6sd6N9seCZfh1QFCk_1745930875
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 29, 2025 at 3:09=E2=80=AFAM Glass Su <glass.su@suse.com> wrote:
>
> Hi dlm folks
>  Recently out team found a dlm timeout bug with lvmlockd. When sctp is us=
ed by dlm as underlying
> protocol, there always are ~10s timeout for dlm to finish dlm_release_loc=
kspace():
>
> Each connection costs DLM_SHUTDOWN_WAIT_TIMEOUT to be shutdown:
>
> > 38794 Apr 11 08:46:54 sapcrt-as2 kern.err kernel: [T1171911] dlm: Conne=
ction 000000001c3b445d shutdown timed out, will force close
>
> It's caused by the following code from fs/dlm/lowcomms.c when releasing a=
 lockspace:
>
> static void shutdown_connection(struct connection *con, bool and_other)
> {
> ...
>
>         ret =3D kernel_sock_shutdown(con->sock, SHUT_WR);
>         up_read(&con->sock_lock);
>         if (ret) {
>                 log_print("Connection %p failed to shutdown: %d will forc=
e close",
>                           con, ret);
>                 goto force_close;
>         } else {
>                 ret =3D wait_event_timeout(con->shutdown_wait, !con->sock=
,
>                                          DLM_SHUTDOWN_WAIT_TIMEOUT);
>                 if (ret =3D=3D 0) {
>                         log_print("Connection %p shutdown timed out, will=
 force close",
>                                   con);
>                         goto force_close;
>                 }
>         }
>
>         return;
>
> force_close:
>         close_connection(con, false);
> }
>
>
>
> The problem is after kernel_sock_shutdown(), shutdown_connection() is wai=
ting con->sock to be NULL(closed)
> until DLM_SHUTDOWN_WAIT_TIMEOUT but there is no other wake_up(&con->shutd=
own_wait) unless the one in
> process_recv_sockets().
>
> Assume there are two nodes in the cluster. kernel_sock_shutdown() is call=
ed by node A, sctp sock
> will send SHUTDOWN to node B. When NODE B receives the SHUTDOWN signal, s=
ctp layer sends
> SHUTDOWN ACK to NODE A. At the moment, NODE A is waiting the connection t=
o be closed until timeout.
> However, lowcomms_state_change() only handles RCV_SHUTDOWN case, in NODE =
A, sk->sk_shutdown
> is SEND_SHUTDOWN even the lower sctp layer received SHUTDOWN ACK from NOD=
E B.
>
> Then we noticed there is commit 54fbe0c15d9a ("fs: dlm: bring back previo=
us shutdown handling=E2=80=9D). Before
> the commit, sctp socks are not shutdown gracefully, all sctp socks are cl=
osed ungracefully. The commit message
> says  =E2=80=9CThis patch( mostly* reverts commit 4f567acb0b86=E2=80=9D.
>
> The commits introduces the issue,  so my question is that is the behavior=
 change of sctp intentional?
> It seems reasonable for the graceful shutdown of sctp socks change though=
.

I will try to reproduce this issue, but SCTP does not have any
graceful shutdown functionality. This does not exist in SCTP, there
should be a way to fake it [0], to at least get a EOF (recv 0 bytes)
on the other end.
With graceful shutdown I also mean half-closed sockets e.g. being able
to still receive but not transmit anymore until the other node tells
EOF, but as I said there are changes that everything works like it
would have such functionality.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lowcomms.c?h=3Dv6.15-rc4#n531

