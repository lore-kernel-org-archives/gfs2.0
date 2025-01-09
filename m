Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691721D580
	for <gfs2@lists.linux.dev>; Thu,  9 Jan 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436879; cv=none; b=soUMQa+EG86H7hQxQaXaRPK7yJxNm216boOqcK5wIYzjoLPJigdmgrzp5RYwYxwNiPD6zXy0S+DWzWvEm9inJ3xbcn1jD/IWD5O9/hb91tasjRR//4lpglFCHyEoW/mbMb/myHgxWdWfSkK9M7VndFAKmj+W1vvgLvUoHbMv8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436879; c=relaxed/simple;
	bh=Ee2EmU9l7vNOdmwo16y68wXHkNLT1Z7XaLmpgbi4J/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxujCYDcKHy0P7hN5bHB5c2BoW5oZ8pYMq2VUkRkS0OfsJ2so7A/JWpRBPK0UF2/Vw8+8N5AVjAFGUxus/xfxyzVPL/KqMvAt4Z8VA+fuvrI8v+RktyuM0A0DVqb34zvSzB9w4SFzkl7IHbOZxzjTgtZip7uIUc7foktUYenqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlSRfiDj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlSRfiDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736436876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udy7PUP4hbb6KQrqsOO5+0G6I6TeV/5xwEaHB84tnNQ=;
	b=FlSRfiDjSgYW10ASqaosbzZTPL8ZOkNzOjNQ1RM/Fzx4TDMbq5HL5CUZmL94hM1kxl+gP2
	Sd85eRWbk9PRjwhCHKFkQTPftnjonDevbSdgqqe3wFOqHdIwXhNlAHGL2vgai09Feq3gWS
	BIpmpx7VowNoYEHzbSGsj+/NAuHHJ+k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-lgobXf81P62ADl9EUb-1Iw-1; Thu, 09 Jan 2025 10:34:35 -0500
X-MC-Unique: lgobXf81P62ADl9EUb-1Iw-1
X-Mimecast-MFC-AGG-ID: lgobXf81P62ADl9EUb-1Iw
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30041b60c83so5274561fa.0
        for <gfs2@lists.linux.dev>; Thu, 09 Jan 2025 07:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736436874; x=1737041674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udy7PUP4hbb6KQrqsOO5+0G6I6TeV/5xwEaHB84tnNQ=;
        b=pBeU2b96CYIE0c2u2AA4g7nswm3b4p4rHFxljqrQ3Cr8SGbhvAzXnk3YRhv1Hvmjh7
         GzPGakTV/bPbtq/iOE5zNzkQpOd8jokI0FFM16HUEHXyHopLJ+pfRh3+g3yK1+IT5aJO
         06jH3jw+01y851qftKQjm23sIzP7Vhy+ze8y/uD2zurvHH+bf2x25QJYLucaA2T0nD1d
         BDfkENuYKWPe8Hsje2rV8r6bWG5LBk68QTsy9nrSNY3hrfUkRQlixlY2GLS20j5abC48
         iefi4ZDl5EtlcRVej/hhThL3tlgX3duxOnnRBwJlov6pA38d8wQCGzAF82gTx04y+Jv/
         uTfA==
X-Forwarded-Encrypted: i=1; AJvYcCWgEVvNMy7GK3ftM7b/qHnJ2u8ytnc/pnsfa5sGKOZkaCpQ9FVd9Klr30KkcPDHq2SOIVdk@lists.linux.dev
X-Gm-Message-State: AOJu0YxgyYJRXGswv6z1q87XN+zrlcRb+ITS3G9K0EWbp3j2iGjVQHSj
	rfL8iNsBS8ECzVrLne0/kdc5Ggq/HmQJ2YnMIUbFg6vs8xRaRFk0PZlojZq+hzTxW2QlMrYwfnq
	WlMHzQtREMC1oGDHJu3Pvp6YTQ85JDZTtuiqaUEQjk21W3DL5o+epdyYjsA1P5I4cGxNuvvciYJ
	MCKXTSDgMPjqJQIolzrEmw2fxGIw==
X-Gm-Gg: ASbGncu1DDpvhPtLQghzn/W80CrEeJrPl3a53uoevaCkHRZUDun31eWYXKIenagDImr
	W/3r5f10N1mYZ0fx7xHvLkYOyeXMdGb6NEGOdk5YGqpOFP7nIGx4KGCHdNrid7uqeK4Xec600
X-Received: by 2002:a05:651c:4cb:b0:302:264e:29dd with SMTP id 38308e7fff4ca-305f45e5433mr22834671fa.24.1736436873614;
        Thu, 09 Jan 2025 07:34:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr0RXXEMLIfsRBQqm5294zsXVZ3A3zhRpag9TDUhWiQ/1bVbRmdrY04VNczKKzC3a0bXACRrAzmhftQHXq7dA=
X-Received: by 2002:a05:651c:4cb:b0:302:264e:29dd with SMTP id
 38308e7fff4ca-305f45e5433mr22833441fa.24.1736436868472; Thu, 09 Jan 2025
 07:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241224084241.13563-1-heming.zhao@suse.com> <20241224084241.13563-2-heming.zhao@suse.com>
 <CAK-6q+gbGg9rQKuKkpLyURN_nY1N+k87YPj1e8HqL_zTy0GgUw@mail.gmail.com>
 <efad042e-6035-4045-b4e8-7798055945a1@suse.com> <CAK-6q+g0YP+40yQ=8KVOSCcknCRmmn6-LfuvseDW1i4uFDqw5Q@mail.gmail.com>
 <f6062ed5-51aa-4c56-a211-87183e6eb853@suse.com>
In-Reply-To: <f6062ed5-51aa-4c56-a211-87183e6eb853@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 9 Jan 2025 10:34:17 -0500
X-Gm-Features: AbW1kvaTPTX2lObNPJux0ap5VQnxspIbSRL437EoFfNlNUV8ArhcGSIWvZgyNvI
Message-ID: <CAK-6q+jRn+fXdby1tCQSoayO4HfpKKQkfUOH6SGJ75ujbNn1ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
To: Heming Zhao <heming.zhao@suse.com>
Cc: teigland@redhat.com, ccaulfie@redhat.com, jfriesse@redhat.com, 
	nicholas.yang@suse.com, glass.su@suse.com, gfs2@lists.linux.dev, 
	Roger Zhou <ZZhou@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qvCc6WiN9gNES0DGT1rsEaOMihW4em2vYSMAy3cvnNo_1736436874
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heming,

On Wed, Jan 8, 2025 at 9:26=E2=80=AFPM Heming Zhao <heming.zhao@suse.com> w=
rote:
>
> On 1/8/25 23:54, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, Jan 6, 2025 at 11:59=E2=80=AFPM Heming Zhao <heming.zhao@suse.c=
om> wrote:
> >>
> >> On 1/7/25 02:11, Alexander Aring wrote:
> >>> Hi Heming,
> >>>
> >>> On Tue, Dec 24, 2024 at 3:42=E2=80=AFAM Heming Zhao <heming.zhao@suse=
.com> wrote:
> >>>>
> >>>> The totem.rrp_mode config item was obsolete in corosync3. And
> >>>> this patch gives dlm_controld the ability to detect multiple
> >>>> links.
> >>>>
> >>>> The corosync and dlm network protocol relationship table:
> >>>>
> >>>>    -------------+-----------------------+---------------------
> >>>>                 | totem.transport=3Dudpu  | totem.transport=3Dudp
> >>>>                 +-----------------------+---------------------
> >>>>    corosync 2.x |            |          |      multicast
> >>>>                 |   1-ring   | 2-ring   |---------------------
> >>>>                 |            |          |  default  | 2-ring
> >>>>    -------------+------------+----------+---------------------
> >>>>       dlm       |     tcp    | sctp     |   tcp     | sctp
> >>>>    -------------+------------+----------+---------------------
> >>>>
> >>>>    -------------+----------------------------+----------------------
> >>>>                 | totem.transport =3D udpu/udp | totem.transport=3Dk=
net
> >>>>    corosync 3.x |----------------------------+----------------------
> >>>>                 |      1-ring                | 1-link  | multi-links
> >>>>    -------------+----------------------------+---------+-----------
> >>>>       dlm       |       tcp                  |  tcp    | sctp
> >>>>    -------------+----------------------------+---------+-----------
> >>>>
> >>>> At last, this patch should be work with updated kernel dlm module.
> >>>
> >>> I am not getting why the network protocol configuration has anything
> >>> to do with the corosync configuration.
> >>> I know that we currently get the address configurations from corosync
> >>> but with this patch we are forced to use SCTP when corosync provides
> >>> more than one "ring" configuration?
> >>
> >> Yes. this patch will force dlm to change to SCTP when corosync provide=
s
> >> more than one "ring".
> >>
> >> The reason:
> >> (without this patch) When a user sets up multi-links on corosync3
> >> and corosync.conf with an incorrect or missing rrp_mode,
> >> dlm_tcp_listen_validate() will trigger 'dlm_local_count > 1' and repor=
t
> >> an error.
> >> Please note, rrp_mode is obsolete; the dlm_daemon will fail to read th=
is
> >> config item in the further. Therefore, the network protocol will
> >> always be TCP.
> >>
> >>>
> >>> Even with corosync3 it should be possible to use corosync in SCTP
> >>> (multiple rings) and the kernel dlm using TCP only, would this not be
> >>> possible with dlm_controld then?
> >>
> >> Only one case for above case: corosync3 on single-link.
> >> A new patch is needed for dlm to work over TCP when corosync3 in SCTP
> >> (multi-link mode). i.e. dlm_tcp_listen_validate() shouldn't return
> >> -EINVAL when 'dlm_local_count > 1'.
> >>
> >
> > I think we should change that condition then.
> >
> >> A key point for dlm is that there is no way to get the corosync versio=
n.
> >> This patch is compatible with corosync2 env. In corosync2, the user mu=
st
> >> correctly config rrp_mode when using 2-ring.
> >>
> >
> > So far I looked into it, it is anyway for detecting a protocol
> > according to some Corosync functionality it should still be possible
> > to always force dlm_controld using a different protocol by setting the
> > right config values/parameters.
>
> Yes, I forgot the config item 'protocol=3D[detect|tcp|sctp]', which can b=
ypass
> the detection phase when its value is "tcp|sctp". But in general, dlm.con=
f
> is seldom used.
>
> Unfortunately, corosync doesn't provide the api.
> ref: https://github.com/corosync/corosync/issues/771

I have the following scenario in my head with detect_protocol().

Currently, if somebody uses knet with UDP and has multiple
"nodelist.node.0.ring%d_addr" defined in Corosync but does not set
"totem.rrp_mode" and there is no "protocol" setting in dlm.conf or as
a parameter (it will use detect_protocol()"), then the DLM kernel will
use TCP.

After your patch the behaviour will be changed and the DLM kernel will
use SCTP with the same configuration as before?

- Alex

